TODO:
-Add spaces where appropriate to the date at the top of each page.  Maybe center align?

-Add interactive mode by using "read" commands

-Add optionality for importing new templates (ie. a running to do list)

-Add variables to allow for
	-editing previous days
	("-y" for yesterday. maybe "-y 5" for back 5 days?
	-editing the template
	



Done:
-Remove the redundant copy of 'journal' script.  I am currently making changes to the journal.sh script and then copying them to 'journal' for ease of exwcution.
Instead, I should have one copy of journal.sh and create a terminal alias from journal to journal.sh.  Way better.

This branches aim is to create a backing up system.
This will require:
-learning how to incorporate parameters into scripts
-reviewing the commands to compress files
-ideally, the user has some way of dictating where the compressed files should land...

if($1){


