#!/bin/bash
#Opens todays journal, creating the file if it doesn't exist.

TODAY=$(date +%F)
JOURNAL_DIR=/media/FILES/journal/
TODAYS_JOURNAL=${JOURNAL_DIR}${TODAY}.jent

#Opens journal Entry for date parameter passed in.
openEntry () {
    if [[ ! -f "$1" ]]; then
      echo $(date '+%A %B %d %Y') >> $1
      cat ${JOURNAL_DIR}TEMPLATE.txt >> $1
    fi
    nano $1
    echo "${TODAY}'s entry updated."
}

#Prints help text
help () {
  echo "Legal arguments:"
  echo "-t	Opens TEMPLATE.txt for modification"
  echo "-h	Display help text"
  echo "-y	Opens yesterday's journal entry.  Numerical arguments"
  echo "	following this option will jump backwards that many days."
}


#check for presence of arguments
if [[ $# -eq 0 ]]; then
  openEntry $TODAYS_JOURNAL
else


#getopts looks for single character options ('-y' in the case below)
#any option with a following colon looks for an argument after the option
#and stores it in the variable OPT

while getopts "thy:" OPT; do
  case $OPT in
  t) nano ${JOURNAL_DIR}TEMPLATE.txt
  ;;
  h) help
  ;;
  y) PREV_DAY=$(date --date=$OPTARG' days ago' +"%F")
     openEntry ${JOURNAL_DIR}${PREV_DAY}.jent
  ;;
  esac
done
fi
exit
