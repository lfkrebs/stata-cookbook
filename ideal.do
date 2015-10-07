********************************************************************************
**                       IDEAL STRUCTURE OF A DO-FILE                         **
********************************************************************************

* This is an example of the ideal start of a do-file, with comments that explain
* each step and why it is useful to do these steps in the order proposed here.
* Feel free to use this as the template for your own do-files in the future.



************************* BEFORE YOU START WORKING... **************************

** SETTING PAGINATION OF MESSAGES OFF -- When manually running commands, it's
* useful that Stata pauses after a screenful of messages so that you have time
* to read the output before it scrolls past. This is less helpful when running
* do-files that create a lot of output, since it forces to you press a key at
* the end of every screen. Switch it off with:

set more off

* By the way: if you want to make the change permanent, you can use 
set more off, permanently
* Now, you don't need to individually switch more off at the start of each
* session or the top of each do-file. Just remember to switch it back on again
* when you do some manual work in Stata.



** CLOSING ANY RUNNING LOG FILE -- Especially when you do a lot of analysis, you
* may already have a log file open. It is good practice to make sure that you
* properly close running log files when you start a new analysis. The best way
* to do this is to use the following command, which closes any open log files
* and does not complain in case no log was open:
capture log close

* Placing capture before log close is what prevents error messages from stopping
* your work in case there actually was not a log file open.



** CHANGE TO YOUR WORKING DIRECTORY -- It's good practice to have one folder
* contains your data, do files and logs. Before switching on logging, we change
* to this working directory or folder. Once we do this, we don't have to bother
* with directory paths when opening data and logs. Here are examples of how to
* change directories under Windows, Mac and Linux, assuming that your user name
* is StataNinja. (Honestly, why wouldn't you want this to be your user name?)

* Windows:
cd "C:\Users\StataNinja"

* Mac:
cd "/Users/StataNinja"

* Linux:
cd "/home/stataninja/"

* The above examples get you to your user directory. Make sure to change them
* to lead you to your specific data directory.



** SWITCH ON LOGGING -- We recommend switching on logging before you open your
* data file or run any commands. This ensures that you always know what data
* file you were working on and captures any commands you run.

* We also recommend that you have a log file for each session that you run, and
* you label them by day and time when you did your analysis. The advantage of
* this approach is that you can easily find, say, the analysis you did last
* Tuesday afternoon, simply by looking at the name of the log file. Stata can
* automatically open a log file with date and time information:

log using "Log `c(current_date)' `c(current_time)'.log", name("HELPFUL NOTE")

* Feel free to change the name of the log, but make sure to keep the commands
* for date and time -- `c(current_date)' and `c(current_time)' -- in the file
* name.

* We also recommend giving each log file a name, like "HELPFUL NOTE" above.
* You can use this to leave a clue to your future self about what you are doing
* in this log file.

* Finally, if you label your log files with date and time, you usually won't
* need to use the "append" or "replace" options. Unless you open another log
* file in less than 60 seconds, your log file will have a unique name that will
* not repeat again, so there is no risk of having a log file with the same name
* in your working directory.



** OPEN YOUR DATA FILE -- It's best to open your data file right at the start of
* your log. Just like naming your log, opening your data file as the very first
* command helps your future self remember what you are doing.

use "My delightful data.dta", clear

* We recommend using the clear option when opening your data file, but this
* creates the risk of data loss since any data in Stata that has not been saved
* yet will be lost. You do remember our recommendation about backing up your
* original data at least once before and after import, right?



************************* YOUR ANALYSIS HAPPENS HERE! **************************

* At this point, you're good to go. We recommend leaving comments to yourself
* next to each block of commands, and to separate logical units of commands
* from each other with a couple of empty lines. For example, if your first set
* commands import and clean the data, followed by blocks of commands that
* describe and analyze the data, put a couple of empty lines between these
* blocks and leave comments like "import", "data cleaning", "descriptives",
* "analysis", "graphs", etc. at the start of each block.

* Of course, you don't have to be as verbose as we are here. :)




*************************** AT THE END OF YOUR WORK ****************************

** SAVE YOUR DATA AS NEEDED -- Be sure to save your data if you have made
* changes to it that you want to safe-guard. Remember to backup your original
* data at least once before and after import. We recommend that you give sub-
* sequent saves a slightly different file name, like:

save "My delightful data RECODED.dta", replace

* Careful with the "replace" option. If you already have a data file with that
* name, it's contents will be overwritten!

* Make sure you save your data while the log file is still open. In case you
* ever need to figure out where a particular version of a data file comes from,
* you'll have the save command on the log and can scroll up to see how you
* generated the data file.



** FINAL MESSAGES -- Just before you close your log is a good time to leave any
* final notes to yourself, like the time and date when your analysis ended:
display "Analysis ends on `c(current_date)' at `c(current_time)'"

* The abbreviated version of "display" is "di":
di "Analysis ends on `c(current_date)' at `c(current_time)'"



** CLOSE YOUR LOG -- It is best practice to close your log at the end of your
* analysis. This ensures that all your data is written to the hard drive before
* you close Stata. 
log close _all

* Using _all here tells Stata to close any log, independent of the helpful name
* we have given it above.


** CLEAN UP -- We recommend clearing your data at the end of your analysis. This
* is good practice because it establishes that at then end of each orderly
* analysis, no data should be in Stata. If you ever run into a situation where
* data is still in memory when the analysis is over, you can treat it as an
* indicator that something went wrong.


** WE HOPE YOU HAVE A GOOD TIME WORKING IN STATA...




