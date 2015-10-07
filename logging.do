********************************************************************************
**                            LOGGING STATA OUTPUT                            **
********************************************************************************

* For reproducibility, it is essential to keep a complete log of what your
* analyses. Stata offers logging functions that automate this task for you --
* the only thing you need to do is switch on the log at the start of each
* analysis and switch it off at the end. In between these two commands, Stata
* will write the following things to the log file:
* _1_ Every command you type or run from a do-file
* _2_ Every comment you make or including in a do-file (handy for annotations!)
* _3_ All output that your commands generate except for graphs.



** OPENING YOUR LOG FILE -- Pretty straightforward:

* This command starts logging immediately in the specified file name
log using "my log filename.log"

* Be sure to include the file name in quotation marks except if the filename is
* one word only.

* Stata knows two file formats for logs, we strongly recommend plain text log
* files, since you can open them in any text editor or word processor like
* Microsoft Word or LibreOffice. As you as the file name ends on .log, Stata
* will save the log in the correct format. However, you can force Stata to play
* nice by explicitly telling it to save the log as text:
log using "my log filename.log", text



* If you using the same log file for analysis in multiple sessions, Stata will
* complain if you are at risk of overwriting an existing file. This forces you
* to choose what you want to do:

* You can CONTINUE the old log file:
log using "my log filename.log", append
* All information in the log file is kept and all new information is added to
* the end of the log file. This is the better option in most circumstances,
* since it avoids any data loss.

* You can OVERWRITE the old log file:
log using "my log filename.log", replace
* You lose everything contained in the log file at this point, so you should
* only use this option if you are sure you can afford to lose this information!



* An easy way to avoid potential data loss is to give each log file a file name
* that includes the date and time when the analysis was started. You can do this
* automatically with the command:
log using "Log `c(current_date)' `c(current_time)'.log"

* Feel free to change the name of the log, but make sure to keep the commands
* for date and time -- `c(current_date)' and `c(current_time)' -- in the file
* name.



* We recommend giving each log file a name:
log using "Log `c(current_date)' `c(current_time)'.log", name("HELPFUL NOTE")
* The name is printed at the very top of the log file and allows you to leave a
* note to your future self about what you are doing in this log file.



* Are you doing unspeakable things to your data that you don't want to record?
* You can pause the log to exclude a part of your analysis from the log:
log off
* All done and want to switch the log back on?
log on

* This is particularly useful if you are exploring or tinkering with your data
* and don't need an actual log of what you are doing. However, there is no harm
* in keeping the log running at all times. Who knows? You might find something
* useful when playing with the data, and if the log isn't on, you don't have a
* record of it...



* At the end of your analysis, you should close your log properly:
log close _all

* This ensures that your log file is properly written to disk. Using _all here
* tells Stata to close any log, independent of the helpful name we have given
* it above.




