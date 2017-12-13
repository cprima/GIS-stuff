#!/bin/bash
#/** 
#  * Download geodata files from various locations.
#  *
#  */

#ToDo: -f to skip asksure _FORCEDOWNLOAD=false
_CONFIGFILE="./application/physical/scripts/conf/config.sh"
_VERBOSE=false

while getopts ":hvyc:" opt; do
  case $opt in
    h) echo "help!"
    ;;
    c) echo _CONFIGFILE=$OPTARG
    ;;
    y) _FORCEYES="true"
    ;;
    v) _VERBOSE="true"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2; echo -n "continuing "; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo ".";
    ;;
  esac;
done

function checkroot {
  i=0
  for d in './data' './application'; do
    if [ ! -d "$d" ]; then i=$((i + 1)); fi
  done
  if [[ $i > 0 ]]; then echo "Aborting."; echo "Not in repository root."; exit 1; fi
}

function checkrequirements {
  i=0;
  type wget >/dev/null 2>&1 || { echo >&2 "This script requires wget but it is not installed. ";  i=$((i + 1)); }
  type unzip >/dev/null 2>&1 || { echo >&2 "This script requires unzip but it is not installed. ";  i=$((i + 1)); }
  type curl >/dev/null 2>&1 || { echo >&2 "This script requires curl but it is not installed. ";  i=$((i + 1)); }
  if [[ $i > 0 ]]; then echo "Aborting."; echo "Please install the missing dependency."; exit 1; fi
} #end function checkrequirements

function asksure {
  echo ${_FORCEYES}
  if [ "${_FORCEYES}" == "true" ]; then
  retval=0
  else
    if [ -z "$1" ]
      then echo -n "Please select [Y]es or [N]o: (Y/N)? "
    else
      echo "${1} (Y/N)"
    fi

  while read -r -n 1 -s answer; do
    if [[ $answer = [YyNn] ]]; then
      [[ $answer = [Yy] ]] && retval=0
       [[ $answer = [Nn] ]] && retval=1
      break
    fi
  done
  fi
echo
return $retval 
} #end function asksure


function download_extract_ratelimited_updated {
  if [ "$_VERBOSE" = "true" ]; then _Q=' '; else _Q='-q'; fi;
  if [ ! -s "./data/incoming/${4}/${2}.${3}" ]; then
    if asksure "Downloading potentially large file ${1}?"; then
       wget --limit-rate=1000k "${1}" -c -O ./data/incoming/${4}/${2}.${3}.partial
       mv ./data/incoming/${4}/${2}.${3}.partial ./data/incoming/${4}/${2}.${3}
       touch ./data/incoming/${4}/${2}.${3}.timestamp
       #touch -d "1 year ago" Natural_Earth_quick_start.zip
    else
      echo "Maybe download later ${1} to ./data/incoming/${4}/${2}.${3}"
    fi
  else
    #existing, so check:
    if [[ "$(curl --limit-rate 1000k ${1} -z ./data/incoming/${4}/${2}.${3}.timestamp -o ./data/incoming/${4}/${2}.${3} --silent --location --write-out %{http_code};)" == "200" ]]; then
      touch ./data/incoming/${4}/${2}.${3}.timestamp
      echo "File ${2}.${3} was updated."
    else
      echo "File ${2}.${3} was unchanged and therefore _not_ updated."
    fi
  fi #end if ! -f $2.${3}
  #if [ -s "./data/incoming/${4}/${2}.${3}" ]; then
  #  unzip ${_Q} -u -o ./data/incoming/${4}/${2}.${3} -d ./data/incoming/${4}/${2}/
  #  echo "File ${2}.${3} unzipped into ./data/incoming/${4}/${2}/ ."
  #fi
} #end function download_extract_naturalearth_ratelimited_updated




######################################################################
#/**
#  * Main part
#  *
#  */

#gethelpers
checkrequirements
checkroot
source $_CONFIGFILE;

for d in './data/incoming/tankerkoenig' './application/physical/gasprices'; do
  if [ ! -d $d ]; then mkdir -p "./$d"; fi
done

download_extract_ratelimited_updated "https://creativecommons.tankerkoenig.de/history/history.dump.gz" "history.dump" "gz" "tankerkoenig"



echo 'export PGPASSWORD=********; dropdb --if-exists -U postgres -h 127.0.0.1 tankerkoenig && createdb -U postgres -h 127.0.0.1 tankerkoenig && gunzip < ./data/incoming/tankerkoenig/history.dump.gz | psql -U postgres -h 127.0.0.1 tankerkoenig'