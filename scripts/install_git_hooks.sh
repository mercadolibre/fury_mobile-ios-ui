#!/bin/sh

GIT_HOOKS_PATH='.git/hooks'
SCRIPTS_PATH='../../scripts'

function crateHooksPathIfNotExists() {
  if [ ! -d $GIT_HOOKS_PATH ]; then
    mkdir $GIT_HOOKS_PATH
  fi;
}

function installHook() {
  scriptName=$1
  ln -s -f "${SCRIPTS_PATH}/${scriptName}" "${GIT_HOOKS_PATH}/${scriptName}"
  chmod +x "${GIT_HOOKS_PATH}/${scriptName}"
}

crateHooksPathIfNotExists
installHook 'pre-commit'