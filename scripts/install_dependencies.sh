#!/usr/bin/env bash

# load rvm ruby
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  source "$HOME/.rvm/scripts/rvm"

elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
  source "/usr/local/rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
  printf "Check https://sites.google.com/mercadolibre.com/mobile/gu%C3%ADas-y-problemas/ruby-tools#h.b70ym3rj05rl for more info \n"
  exit 1
fi

rubyVersion=`cat .ruby-version`

if rvm list | grep $rubyVersion ; then
  rvm use $rubyVersion
else
  echo "Ruby $rubyVersion not found, using rvm to install"
  if rvm install $rubyVersion ; then
    rvm use $rubyVersion
  else
    echo "rvm install failed, please install dependencies manually, use bundle install and bundle exec pod install"
    exit 1
  fi
fi

bundle install

bundle exec pod install
