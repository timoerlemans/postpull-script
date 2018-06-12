#!/bin/bash
# function to check if program is installed (npm global)
function program_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

function check_gulp {
  if [ $1 == 1 ]; then
    echo "Gulp CLI is already installed, skipping"
  else
    echo "Gulp CLI is not yet installed, installing"
    npm i gulp-cli -g
  fi
}

function check_yarn {
  if [ $1 == 1 ]; then
    echo "Yarn is already installed, skipping"
  else
    echo "Yarn is not yet installed, installing"
    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
    sudo yum install yarn
  fi
}

echo -e "\e[36m-- Check if yarn is installed --\e[0m"
(check_gulp $(program_is_installed yarn))

echo -e "\e[36m-- Running yarn --\e[0m"
yarn

echo -e "\e[36m-- Check if Gulp CLI is installed --\e[0m"
(check_gulp $(program_is_installed gulp))

echo -e "\e[36m-- Running Gulp --\e[0m"
gulp
