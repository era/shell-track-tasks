#!/usr/bin/env bash

FILE=$SHELL_TRACK_TASK_FILE

today_date() {
   date +"%Y-%m-%d %T"
}

create_new_entry() {
    jq ".entries +=[$1]" $FILE|sponge $FILE
}

find_entries() {
    jq ".entries | map( select(.date | test(\"$1\"; \"i\")))" $FILE 
}

helpFunction() {
   echo ""
   echo "Usage: $0 -a description"
   echo "\t-a Adds a task with \"description\""
   echo ""
   echo "Usage: $0 -f -1d"
   echo "\t-b Describes all entries at -1d (yesterday)"
   echo ""
   echo "Usage: $0 -l"
   echo "\t-b Lists all tasks ever created"
   exit 1
}
while getopts "a:f:l" opt
do
   case "$opt" in
      a ) description="$OPTARG" ;;
      f ) from="$OPTARG" ;;
      l ) list=true ;;
      ? ) helpFunction ;;
   esac
done

if [ -z "$description" ] && [ -z "$from" ] && [ -z "$list" ]; then
   echo "Wrong usage";
   helpFunction
fi

#CREATE FILE IF DOES NOT EXISTS
if [ ! -f  $FILE ]; then
    echo "{\"entries\": []}" > $FILE
fi

if [ ! -z "$description" ]; then
    create_new_entry "{\"date\": \"$(today_date)\", \"description\": \"$description\"}"
    exit 1
fi
if [ ! -z "$list" ]; then
    jq ".entries" $FILE 
    exit 1
fi

if [ ! -z "$from" ]; then
    wanted_entry=$(date -v $from +'%Y-%m-%d')
    find_entries $wanted_entry
    exit 1
fi