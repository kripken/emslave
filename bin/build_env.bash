#!/bin/bash

if [ -z "$SLAVE_NAME" ]; then
    echo "Need to set SLAVE_NAME env. var before running build_env.bash!"
    exit 1
fi

if [ -z "$SLAVE_ROOT" ]; then
    echo "Need to set SLAVE_ROOT env. var before running build_env.bash!"
    exit 1
fi

pushd $SLAVE_ROOT/buildslave/$SLAVE_NAME/emsdk > /dev/null
source ./emsdk_env.sh --embedded
popd > /dev/null

echo "System version information: (uname -a):"
uname -a

if which lscpu >/dev/null; then
	echo "CPU information (lscpu):"
	lscpu
fi
if which lsb_release >/dev/null; then
	echo "Linux distribution (lsb_release -a):"
	lsb_release -a
fi

echo "Node version:"
which node
node --version
echo "Clang version:"
which clang
clang --version

echo "Currently checked out emscripten branch:"
git log -n1

echo "Currently checked out emscripten-fastcomp branch:"
pushd $SLAVE_ROOT/buildslave/$SLAVE_NAME/emsdk/clang/fastcomp/src > /dev/null
git log -n1
popd > /dev/null

echo "Currently checked out emscripten-fastcomp-clang branch:"
pushd $SLAVE_ROOT/buildslave/$SLAVE_NAME/emsdk/clang/fastcomp/src/tools/clang > /dev/null
git log -n1
popd > /dev/null

echo "ENVIRONMENT VARIABLES: "
echo "- SLAVE_ROOT: "
echo $SLAVE_ROOT
echo "- SLAVE_NAME: "
echo $SLAVE_NAME
echo "- PATH: "
echo $PATH
echo "- EM_CONFIG: "
echo $EM_CONFIG
echo "- EM_CACHE: "
echo $EM_CACHE
echo "- EMSCRIPTEN: "
echo $EMSCRIPTEN
echo "- EMSCRIPTEN_TEMP: "
echo $EMSCRIPTEN_TEMP
echo "- EMSCRIPTEN_BROWSER: "
echo $EMSCRIPTEN_BROWSER
echo "- BINARYEN_ROOT: "
echo $BINARYEN_ROOT
echo "- SPIDERMONKEY: "
echo $SPIDERMONKEY
echo "- FIREFOX_STABLE_BROWSER: "
echo $FIREFOX_STABLE_BROWSER
echo "- FIREFOX_BETA_BROWSER: "
echo $FIREFOX_BETA_BROWSER
echo "- FIREFOX_AURORA_BROWSER: "
echo $FIREFOX_AURORA_BROWSER
echo "- FIREFOX_NIGHTLY_BROWSER: "
echo $FIREFOX_NIGHTLY_BROWSER
echo "- MACOSX_DEPLOYMENT_TARGET: "
echo $MACOSX_DEPLOYMENT_TARGET
echo "- LLVM_CMAKE_ARGS: "
echo $LLVM_CMAKE_ARGS

echo "Setting unbuffered python mode.."
export PYTHONUNBUFFERED=1
