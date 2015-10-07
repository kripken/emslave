#!/bin/bash

if [ -z "$SLAVE_NAME" ]; then
    echo "Need to set SLAVE_NAME env. var before running run_firefox_tests.bash!"
    exit 1
fi

if [ -z "$FIREFOX_BROWSER" ]; then
    echo "Need to set FIREFOX_BROWSER env. var before running run_firefox_tests.bash!"
    exit 1
fi

if [ -z "$TEST_RUNNER_PARAMS" ]; then
    echo "Need to set TEST_RUNNER_PARAMS env. var before running run_firefox_tests.bash!"
    exit 1
fi

source build_env.bash

echo "Killing any old leftover firefox processes:"
pkill -9 -x firefox

echo "Removing old Firefox user profile and creating a new one.."

rm -rf ~/emslave/emscripten_firefox_profile/
mkdir ~/emslave/emscripten_firefox_profile/
cp ~/emslave/firefox_profile_template/* ~/emslave/emscripten_firefox_profile/

export EMSCRIPTEN_BROWSER="$FIREFOX_BROWSER -profile $HOME/emslave/emscripten_firefox_profile/"

echo "ENVIRONMENT VARIABLES: "
echo "- EMSCRIPTEN_BROWSER: "
echo $EMSCRIPTEN_BROWSER

echo "Running browser tests.."
python tests/runner.py $TEST_RUNNER_PARAMS skip:browser.test_html_source_map
rc=$?
echo "Test run finished. Killing any running firefox processes:"
pkill -9 -x firefox

exit $rc

