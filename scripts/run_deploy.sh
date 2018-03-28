#!/bin/sh

bundle install --gemfile=.fastlane/Gemfile 
bundle exec fastlane start_deploy