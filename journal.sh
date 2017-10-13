#!/bin/bash
#Opens todays journal, creating the file if it doesn't exist.

TODAY=$(date +%F)
JOURNAL_DIR=/media/FILES/journal/
TODAYS_JOURNAL=${JOURNAL_DIR}${TODAY}.jent

openEntry ()
{
#place journal opening code here.  Access parameters passed in by $1, $2, etc.
echo "hello"
}

#getopts looks for single character options ('-y' in the case below)
#any option with a following colon looks for an argument after the option
#and stores it in the variable OPT
while getopts "y:" OPT; do
  case $OPT in
  

  *)
    if [[ ! -f "$TODAYS_JOURNAL" ]]; then
      echo $(date +%A%B%d%Y) >> $TODAYS_JOURNAL
      cat ${JOURNAL_DIR}TEMPLATE.jent >> $TODAYS_JOURNAL
    fi
    nano $TODAYS_JOURNAL
    echo "${TODAY}'s entry updated."
  ;;
  esac

done

exit
