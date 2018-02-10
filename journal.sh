#!/bin/bash
#Opens todays journal, creating the file if it doesn't exist.

TODAY=$(date +%F)
JOURNAL_DIR=/media/FILES/journal/
TODAYS_JOURNAL=${JOURNAL_DIR}${TODAY}.jent

#Opens journal Entry for date parameter passed in.


####BUGGY CODE!!!  Opening yesterdays journal prints todays date
####at the top of the entry.


openEntry () {
    if [[ ! -f "$1" ]]; then
      echo $(date '+%A %B %d %Y') >> $1
      cat ${JOURNAL_DIR}TEMPLATE.txt >> $1
    fi

    echo >> $1; echo >> $1; echo $(date +%R) >> $1
    focuswriter $1
    echo "${TODAY}'s entry updated."
}


deleteEntry () {
  echo "Do you really want to delete today's entry?!?"
  read -p "Type 'yes' to confirm: " answer
  if [[ $answer = 'yes' ]]; then
    rm $TODAYS_JOURNAL
    echo "Today's entry deleted"
  else
    echo "Deletion cancelled"
  fi
}

#Prompts for each individual line in the template, allowing for
#a more convenient method of entering the ABC's of the day
interactiveMode () {

  if [[ ! -f $TODAYS_JOURNAL ]]; then
    echo $(date '+%A %B %d %Y') >> $TODAYS_JOURNAL
    echo >> $TODAYS_JOURNAL
    while read line; do
      echo $line
      read -u 3 input
      echo "${line} ${input}" >> $TODAYS_JOURNAL

    done 3<&0 < ${JOURNAL_DIR}TEMPLATE.txt
    for counter in {1,2}; do
      echo "" >> $TODAYS_JOURNAL
    done
  fi

  openEntry $TODAYS_JOURNAL
}

#Prints help text
help () {
  echo "Legal options:"
  echo "-t	Opens TEMPLATE.txt for modification"
  echo "-h	Display help text"
  echo "-y	Opens yesterday's journal entry.  Numerical arguments"
  echo "	following this option will jump backwards that many days."
  echo "-d	Deletes todays journal entry after prompting"
  echo "-i	Interactive mode.  Enter todays stats from the terminal."
  echo "-r	Read a few recent entries"
}

#Print previous 3 entries out to terminal
printOlder () {
  more $(ls -t ${JOURNAL_DIR}20* | head -3)
}

#************#
#    MAIN    #
#************#

#check for presence of arguments
if [[ $# -eq 0 ]]; then
#  openEntry $TODAYS_JOURNAL
   interactiveMode
else


#getopts looks for single character options ('-y' in the case below)
#any option with a following colon looks for an argument after the option
#and stores it in the variable OPT

while getopts "thy:dir" OPT; do
  case $OPT in
  t) nano ${JOURNAL_DIR}TEMPLATE.txt
  ;;
  h) help
  ;;
  y)PREV_DAY=$(date --date=$OPTARG' days ago' +"%F")
    TODAYS_JOURNAL="${JOURNAL_DIR}${PREV_DAY}.jent"
    interactiveMode

  ;;
  d) deleteEntry
  ;;
  i) interactiveMode
  ;;
  r) printOlder
  ;;
  esac
done
fi
exit
