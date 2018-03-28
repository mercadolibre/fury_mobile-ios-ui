#!/bin/sh

function usage {
  echo
  echo "Usage: $0 [--path <path>] [--config <config_file>] [--check]"
  echo
  echo "Options:"
  echo "--path   : Path where find files to apply uncrustify"
  echo "--config : Config file to use (.cfg)"
  echo "--check  : Verify if there are files without correct format"
  echo
}

function validateUncrustify {
  errorMessage="Uncrustify v$REQUIRED_MAJOR_V.$REQUIRED_MINOR_V is required\nTo install Uncrustify run: 'brew update && brew install uncrustify'"
  version=`uncrustify --version 2> /dev/null`
  if [ $? -ne 0 ]; then
    echo $errorMessage
    exit 1
  fi

  version=`echo $version | sed 's/uncrustify //'`
  majorVersion=`echo $version | cut -f1 -d.`
  minorVersion=`echo $version | cut -f2 -d. | cut -f1 -d_`
  if [[ $majorVersion -lt $REQUIRED_MAJOR_V || ($majorVersion -eq $REQUIRED_MAJOR_V && $minorVersion -lt $REQUIRED_MINOR_V) ]]; then
    echo $errorMessage
    exit 1
  fi
}

function validateConfigFile {
  if [ ! -f $CONFIG_FILE ]; then
      echo "Config file not found!"
      exit 1
  fi
}

function validateSearchPath {
  for path in "${SEARCH_PATH[@]}"; do
    if [ ! -d $path ]; then
      echo "'$path' is not a valid path"
      exit 1
    fi
  done
}

function checkFormatFiles {
  uncrustify -l OC --check -c $CONFIG_FILE $(find ${SEARCH_PATH[@]} -name "*.[h,m]" -type f) 1> /dev/null
  if [ $? -ne 0 ]; then
    echo "There are files without correct format, please run uncrustify."
    exit 1
  fi
}

function formatFiles {
  uncrustify -l OC --no-backup --replace -c $CONFIG_FILE $(find ${SEARCH_PATH[@]} -name "*.[h,m]" -type f)
}

CHECK=false
 SEARCH_PATH[0]='.'
 CONFIG_FILE='uncrustify.cfg'
 REQUIRED_MAJOR_V=0
 REQUIRED_MINOR_V=66

 while [[ $# > 0 ]]; do
   key="$1"
  case $key in
      --check)
      CHECK=true
      ;;

      -p|--path)
      i=0
      while [[ $# > 1 && ! $2 =~ ^\-{1,2}.+ ]]; do
        SEARCH_PATH[$i]="$2"
        i=$((i + 1))
        shift # past argument
      done
      ;;

      -c|--config)
      CONFIG_FILE="$2"
      shift # past argument
      ;;

      -h|--help)
      usage
      exit
      ;;

      *) # unknown option
      echo "Unknown option: $key"
      usage
      exit
      ;;
  esac
  shift # past argument or value
done

validateUncrustify
validateConfigFile
validateSearchPath

if $CHECK; then
  checkFormatFiles
else
  formatFiles
fi