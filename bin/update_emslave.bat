@echo off

IF "%SLAVE_NAME%"=="" (GOTO error_no_slave_name)
IF "%SLAVE_ROOT%"=="" (GOTO error_no_slave_root)
IF "%TARGET_EMSCRIPTEN_BRANCH%"=="" (GOTO error_no_emscripten_branch)

cd "%SLAVE_ROOT"
call git pull

IF NOT EXIST %SLAVE_ROOT%\buildslave\%SLAVE_NAME% GOTO error_no_slave_dir

IF EXIST %SLAVE_ROOT%\buildslave\%SLAVE_NAME%\emsdk GOTO emsdk_exists
cd %SLAVE_ROOT%\buildslave\%SLAVE_NAME%
call git clone https://github.com/juj/emsdk/
cd emsdk

:emsdk_exists
cd %SLAVE_ROOT%\buildslave\%SLAVE_NAME%\emsdk
call git pull

set EMSDK_TARGETS=sdk-%TARGET_EMSCRIPTEN_BRANCH%-64bit crunch-1.03 java-7.45-64bit spidermonkey-nightly-2015-04-12-64bit
call emsdk install --vs2015 --build-tests %EMSDK_TARGETS%
del %userprofile%\.emscripten
call emsdk activate --vs2015 --embedded %EMSDK_TARGETS%
echo "This file should not be read, nothing but errors here!" > %userprofile%\.emscripten

EXIT /B %ERRORLEVEL%

:error_no_slave_dir
echo ERROR: %SLAVE_ROOT%\buildslave\%SLAVE_NAME% should exist at this point?!
goto :eof

:error_no_emscripten_branch
echo Need to set TARGET_EMSCRIPTEN_BRANCH env. var to either 'master' or 'incoming' before running update_emslave.bat!
goto :eof

:error_no_slave_root
echo Need to set SLAVE_ROOT env. var before running update_emslave.bat!
goto :eof

:error_no_slave_name
echo Need to set SLAVE_NAME env. var before running update_emslave.bat!
goto :eof