#!/bin/bash

# color params
dot_color_none="\033[0m"
dot_color_dark="\033[0;30m"
dot_color_dark_light="\033[1;30m"
dot_color_red="\033[0;31m"
dot_color_red_light="\033[1;31m"
dot_color_green="\033[0;32m"
dot_color_green_light="\033[1;32m"
dot_color_yellow="\033[0;33m"
dot_color_yellow_light="\033[1;33m"
dot_color_blue="\033[0;34m"
dot_color_blue_light="\033[1;34m"
dot_color_purple="\033[0;35m"
dot_color_purple_light="\033[1;35m"
dot_color_cyan="\033[0;36m"
dot_color_cyan_light="\033[1;36m"
dot_color_gray="\033[0;37m"
dot_color_gray_light="\033[1;37m"

########## Basics setup

function msg()
{
    printf '%b\n' "$dot_color_yellow$*$dot_color_none" >&2
}

function prompt()
{
    printf '%b' "$dot_color_purple[+] $*$dot_color_none "
}

function step()
{
  msg "\n$dot_color_yellow[→] $*"
}

function info()
{
  msg "$dot_color_cyan[>] $*"
}

function success()
{
  msg "$dot_color_green[✓] $*"
}

function error()
{
  msg "$dot_color_red_light[✗] $*"
}

function tip()
{
  msg "$dot_color_red_light[!] $*"
}

function is_file_exists()
{
  [[ -e "$1" ]] && return 0 || return 1
}

function is_dir_exists()
{
  [[ -d "$1" ]] && return 0 || return 1
}

function is_program_exists()
{
  if type "$1" &>/dev/null; then
    return 0
  else
    return 1
  fi;
}

function must_file_exists()
{
  for file in $@; do
    if ( ! is_file_exists $file ); then
      error "You must have file *$file*"
      exit
    fi;
  done;
}

function better_program_exists_one()
{
  local exists="no"
  for program in $@; do
    if ( is_program_exists "$program" ); then
      exists="yes"
      break
    fi;
  done;
  if [[ "$exists" = "no" ]]; then
    tip "Maybe you can take full use of this by installing one of ($*)~"
  fi;
}

function must_program_exists()
{
  for program in $@; do
    if ( ! is_program_exists "$program" ); then
      error "You must have *$program* installed!"
      exit
    fi;
  done;
}
