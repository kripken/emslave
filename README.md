# emslave
Unit test slave configuration for Emscripten compiler buildbot slaves.

# Buildslave setup

1. Install python, pip and pip install buildbot-slave

2. Set up the buildslave directory (assumed at ~/emslave/):

    cd ~
    git clone https://github.com/juj/emslave

    cd ~/emslave/
    mkdir buildslave
    cd buildslave

    mkdir $SLAVE_NAME/
    cd $SLAVE_NAME/

    git clone https://github.com/juj/emsdk
    cd emsdk
    ./emsdk install sdk-incoming-64bit

    buildslave create-slave . demon.fi:9989 slavename slavepassword

3. Add ~/emslave/bin permanently to PATH, e.g.

    echo export PATH=\$PATH:~/emslave/bin > ~/.bash_profile

# Buildslave startup

    cd ~/emslave/buildslave
    buildslave start
