#!/bin/bash
#Opens todays journal, creating the file if it doesn't exist.

TODAY=$(date +%F)
JOURNAL_DIR=/media/FILES/journal/
TODAYS_JOURNAL=${JOURNAL_DIR}${TODAY}.jent
if [ ! -f "$TODAYS_JOURNAL" ]
then
  echo "file not present"
  echo $(date +%A%B%d%Y) >> $TODAYS_JOURNAL
  cat ${JOURNAL_DIR}TEMPLATE.jent >> $TODAYS_JOURNAL
fi

nano $TODAYS_JOURNAL
echo $JOURNAL_DIR
echo $TODAY

exit
