#!/bin/bash

## where user excute the setup.sh
CUR_PATH=`pwd`
## get the real path of setup.sh
SOURCE="${BASH_SOURCE[0]}"
FILE_NAME="$(basename "$SOURCE")"
# resolve $SOURCE until the file is no longer a symlink
while [ -L "$SOURCE" ]; do
  APP_PATH="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  # if $SOURCE was a relative symlink, we need to resolve it relative to the path
  # where the symlink file was located
  [[ $SOURCE != /* ]] && SOURCE="$APP_PATH/$SOURCE"
done
APP_PATH="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

export PATH=$PATH:$APP_PATH

USERNAME="$(whoami)"
printf '$USSERNAME IS :'"$USERNAME\n"

dir_android_common="android_common"
dir_personal="personal"
source common.sh
source $APP_PATH/$dir_android_common/android_common.sh
// TODO check personal.sh
source $APP_PATH/$dir_personal/personal.sh

function end_prompt()
{
    prompt "Installation complete... press ENTER to exit.  "
    read
}

function setup()
{
    android_adb
    android_fastboot
    end_prompt
}

# main

setup
