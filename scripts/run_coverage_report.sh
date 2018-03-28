#!/bin/bash

bundle exec slather
bash <(curl -s https://codecov.io/bash) -f coverage/cobertura.xml -X coveragepy -X gcov -X xcode -t $CODECOV_REPO_TOKEN