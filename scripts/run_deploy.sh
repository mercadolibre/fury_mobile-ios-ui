#!/bin/sh

bundle install --gemfile=.fastlane/Gemfile 
BUNDLE_GEMFILE=.fastlane/Gemfile bundle exec fastlane start_deploy