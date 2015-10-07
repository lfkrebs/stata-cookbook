********************************************************************************
**                          BASIC COMMAND LINE USAGE                          **
********************************************************************************

* For the purpose of this introductory cookbook, we use one command only:
* summarize. This comamnd provides basic descriptive statitics for one or more
* variables in your dataset, including the number of observations, their mean
* value and standard deviation, as well as the largest and smallest value.

* All examples are based on the Kyrgyz household survey, and particularly the
* POVERTY.dta dataset.



* USING ONE OR MORE VARIABLES
* Most commands can be applied to one or more variables. To apply the command
* to ALL variables, enter the command only:
summarize

* To apply the command to individual variables, list them after the command,
* separated by a space:

summarize toty totx

* You can use wildcards to save yourself some typing. The asterisk * stands for
* any character or characters (one or many). For example:

summarize y*

* ... is the same as listing every single variable whose name starts with a Y:

summarize y1 y2 y3 y5 y6 y7 y8 y9 y10 y11 y12 y13 y41 y42 y42 y44 y45 y46

* Another wildcard is the question mark ? standing for any one character:

summarize y?3

* is the same as listing every single variable whose name started with a Y,
* followed by any character and ending with a 3:

summarize y13 y43



* ABBREVIATING VARIABLES NAMES
* Stata is all about saving you some typing. The most common commands can be
* abbreviated a lot, e.g. summarize can be abbreviated to "su". Writing:

su toty

* is the same as writing

summarize toty

* If you want to know if you can abbreviate a variable name, use the help
* function:

help summarize

* Under syntax, the abbreviated version of the variable name will be underlined.


* USING ALL OBSERVATIONS OR A SUBSET
* By default, Stata will apply the command to all observations for your
* variable, possibly excluding any missing values. But sometimes you don't want
* all observations, but only a subset. For example, the following command will
* give you a summary of the variables for total household income and
* expenditure.

summarize toty totx

* But perhaps you care only about households in rural or urban areas. The
* variable b002 tells you if a household is in an urban (1) or rural (2) area.
* This command summarizes income and expenditure for urban households by
* telling Stata to only include observations if the area indicator has the
* right value.

* Here are the summary values for urban households:

summarize totx toty if b002 == 1

* ... and here for rural households:

summarize totx toty if b002 == 2

* You will usually find that rural households have a lower average income and
* higher average expenditures. Makes sense!

* You can force Stata to take a subset of observations that fulfills multiple
* options at the same time (logical AND). The following command gives us rural
* households with no children under 14 living at home. We use the ampersand
* character & to say AND:

summarize totx toty if b002 == 2 & child14 == 0

* The average expenses are usually lower than the average for all rural
* households. Makes sense!

* You can also ensure that Stata checks whether one of several conditions is
* fulfilled (logical OR). The following command gives us all households who
* have some income from work:

summarize totx toty if y1 > 0

* And this command gives us all households who have some income from pensions:

summarize totx toty if y2 > 0

* This command here gives us all households who have income from work OR from
* pensions. We use the pipe character | to say OR:

summarize totx toty if y1 > 0 | y2 > 0

* Notice something? The total amount of households with some income from either (4801) is less than the sum of the households who have
* income from work (4069) and from pensions (2307). Logically, there
* must be 1575 households who have some income from work and
* additionally some income from pensions!



* AUTO-COMPLETING VARIABLE NAMES
* Note that you can use the tab key to extend a variable name. This
* works fine if there is only one variable name that you could mean.
* Try typing "summarize xs" and then press the tab key -->|  You'll
* get:

summarize xserv 

* If you could mean many different names, Stata won't do anything.
* Try typring "summarize y1" and then press the tab key -->|  Stata
* won't do a thing. That's because you could mean y1, y10, y11, y12
* or y13 -- and Stata does not know which one you want.

* If there are multiple options, but Stata can save you some typing,
* it will go all the way to the letter where you have to make a
* choice: Try typring "summarize qui" and then press the tab key -->|
* You'll get:

summarize quintil

* That's because there are two possible variables: quintilc and
* quintilx. Stata doesn't know which one you want, but will
* auto-complete to quintil and leave the choice for the final letter
* to you.




********************************************************************************
**                              IMPORTING DATA                                **
********************************************************************************


* Stata can import data in a variety of formats. The two most common formats are
* text files (comma-separated values = csv), and Excel files. Virtually all data
* is either delivered in either of these formats, or can be exported into one
* of these formats.



** WARNING

* Before you import new data, make sure that any existing data has been saved
* and cleared from Stata memory!



** COMMA-SEPARATED VALUE TEXT FILES

* The "less messy" way is to import from a text file. This is very plain file
* format that does not require a lot of disk space, and Stata is pretty smart
* when reading this file format. Usually, you can simply import with:
import delimited "filename.csv"

* Stata will treat the first row as variable names, detect the types of
* varibales automatically and import all observations into memory.

* Be sure to check your data after import, pay particular attention to the
* following problems:

*  1  Do the variable names look ok? If not, re-import or re-label
*  2  Are numeric variables actually numeric? If not, see if you can recognize
*     the source of the problem, e.g. decimal commas when Stata expects decimal
*     points. Fix the problem, then use
      destring variablename, replace
*     to fix the problem. Not solved? Try re-importing using the import dialog.
*  3  Check if categorical variables are displayed as numbers. If so, you may
*     want to give each value a label (see labeling.do).
*  4  Check that all observations were imported. If anything is missing, try
*     re-importing using the import dialog.

* As you may have noticed, an easy problem-solving approach is to first import
* with "import delimited", and if problems show up, revert to the regular dialog
* you can find under File > Import > Text data delimited in the Stata menu.
* Using this dialog allows you to adjust all import options while checking a
* preview of what the imported data will look like. Once you are happy with the
* settings, the import dialog will produce the corresponding command. Make sure 
* your log is on so that you capture the correct command.



** MICROSOFT EXCEL

* The "slightly more messy" way is to import from an Excel sheet. Stata can work
* with old and new Excel sheets (.xls and .xlsx, respectively). Because Excel
* sheets can contain multiple worksheets, and because each worksheet can
* contain multiple tables, you have to specify where the table you want to
* import is located by giving the name of the worksheet and the top-left and
* bottom-right corners of the table.

* Open your workbook in Excel and take note of the name of the worksheet. Excel
* files created on an English-language Mac or PC tend to name their sheets
* "Sheet1", "Sheet2", etc. However, these labels are different if the workbook
* was created on a computer with a different language, and the user can change
* the names of the sheets as well. It's best to copy the name to the clipboard
* excactly: double click on the worksheet name (printed on the tab at the
* bottom of the Excel window). The name is now highlighted and can be copied and
* pasted into the Stata command below.

* Next, check whether your table has the names of the variables in the first
* row only. Stata only accepts variable names in the top-most row, but Excel
* has no such restrictions. If you have variable names in more than one row,
* adjust your table so that the top row has clear, unique variable names and
* every other row has individual observations.

* Finally, take note of the top-left and bottom-right cells of the table you
* want Stata to import. E.g. if you have a table that starts at the top-left of
* the sheet and has ten columns and ten rows, the top-left cell would be A1 and
* the bottom-right cell would be J10.

* Adjust the command below with the right name and range to import the table
* from Excel:
import excel "filename.xlsx", sheet("Sheet1") cellrange(A1:J10) firstrow

* If you have only observations and no variable names, you need to skip the
* "firstrow" option.

* If you have trouble importing from Excel with the above steps, use the import
* dialog by choosing File > Import > Excel spreadsheet from the Stata menu.
* The dialog allows you to select the proper sheet and enter the right cell
* range; and provides you with a preview of what Stata will import so you can
* check that the settings are correct.



** OTHER FILE TYPES
* Stata allows importing from other file types, including XML (a prominent new
* file format often used for online data), SAS (a different statistics
* package), and various text files.

* You won't need these file types in the near future, and they are comparatively
* rare. We recommend two options:

*  1  If possible, export or convert these files into Excel or CSV format. These
*     formats are sufficiently standardized and "well-behaved" that adding this
*     step often makes the overall process less painful.
*  2  Use the individual import mechanisms offered in the Stata menu under
*     File > Import. The custom dialogs will walk you through the process of
*     importing the data you need and often allow you to preview the import so
*     you can check for problems. Make sure you are already logging while
*     importing, so that the log captures the correct import command.



** IMPORTING FROM DATABASES

* Stata can connect directly from databases. This usually requires specific
* settings that specify where the database is located (usually on a server on
* the internet), any user name and password that may be needed to get access,
* and how Stata should communicate with the database.

* Should you need to connect to a database, make sure that you have the
* documentation specific for that database and use the "odbc" command to connect
* to it. You can find out more here:
help odbc




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




********************************************************************************
**                       LABELING VARIABLES AND VALUES                        **
********************************************************************************

* It is essential that variables and values in your data set are carefully named
* and labeled. Good variable names reduce the amount of typing you have to do,
* good variable labels help you (in the future) to remember what information is
* contained in each variable, and correct value labels make sure that
* categorical information is correctly understood and analyzed.



** (RE-)NAMING YOUR VARIABLES -- Especially when importing data from other
* sources, you may find that the variable names are not as succinct as they
* could be.

* You can easily rename variables using:
rename oldname newname
* As long as the oldname correctly identifiea an existing variable and the new
* name is an acceptable name, Stata will rename the variable for you.

* The abbreviated version of "rename" is "ren":
ren old new

* As an example, let's say that we got household data that includes the number
* of children under 5 and under 14 in a household, and the data was in an Excel
* sheet with the very clear, but verbose variable names:
*     No. of children aged <=5
*     No. of children aged <=14
* Upon importing the data into Stata, the variable names become:
*     noofchildrenaged5
*     noofchildrenaged14
* This is hard to read and cumbersome to type. We could rename these variables
* to something shorter, but still sufficiently clear:
rename noofchildrenaged5 child5
rename noofchildrenaged14 child14

* You will want to rename your variables right after importing, so that all
* future commands use the new names consistently. If you rename variables in the
* middle of your do-file, you may have commands referring to the same variable
* but using the old name before the renaming command and the new name after the
* renaming command. Because these names are different, somebody reading your
* code will have a harder time seeing that you are working with the same
* variable. Ergo: rename right after import.

* Nota bene:
* For the KIHS, the names are already pretty good, because the dataset is
* created by professional statisticians who understand the ways in which
* statistical packages tend to work. We request that you stick to the original
* variable names so that we have an easier time reading your do-file.



** LABELING YOUR VARIABLES -- In Stata, variable names are meant to be short and
* to the point, so that they quick to type and easy to understand. However, 
* variable names are usually to brief to contain all information you will need.
* For this reason, Stata offers variable labels, which can contain a lot more
* information.

* Ideally, even the simplest variables should have a label and we encourage
* proper labeling in every dataset you work on. While you may not be creating
* data sets that will be distributed to many users (yet!), you do have one all-
* important constituent who needs to understand your data: yourself in the
* future. Careful labeling helps you understand your own data set when you come
* back to it in a few weeks, months or even years. If you label your data now,
* you won't have to travel back in time to punish yourself for making your own
* life harder.

* There's an additional benefit to labeling data: writing good variable labels
* forces you to think carefully about what each variable contains. If something
* is unclear to you know (e.g. what currency is this income data in?), you can
* probably investigate and fix this problem, or you are at least aware that a
* problem exists and needs to be taken into account when interpreting the data.

* To give any variable a label, use:
label variable some_variable "Description of the variable, up to 80 characters"

* The abbreviated version is:
la var variable "Description of the variable, up to 80 characters"


** LABELING VALUES OF CATEGORICAL VARIABLES -- Many datasets contain categorical
* variables which are stored as numerical codes that have an assigned meaning.
* Labeling the values is what tells Stata (and the users of the data set) which
* numerical code stands for which meaning.

* Assigning value labels proceeds in two steps. First, you create a list of the
* numerical codes (or values) and their label appropriate label:
label define name_of_this_set_of_values 1 "What does 1 stand for?" 2 "What..."
* Then, you tell Stata to use this set of labels on a particular variable
label values variable_name name_of_this_set_of_values

* We might have a marital status variable with different categories:
label define statuslabels 0 "not married" 1 "married" 2 "divorced" 3 "widowed"
label values maritalstatus statuslabels

* The abbreviated versions of this commands are "la de" and "la val":
la de genderlabels 0 "male" 1 "female"
la val gender genderlabels

* Your set of value labels can contain tens of thousands of value-label pairs.



** THE CODEBOOK -- If you have received a properly labeled dataset from a source
* or if you labeled a dataset yourself, you can use the
codebook
* command to get a comprehensive overview of all variables. For each variable,
* you will get the name, the label, the type of the variable, and useful
* summary statistics such as the number of missing observations, the range,
* average, standard deviation and percentiles (for numeric information), or a
* tabulation (for categorical information).

* Especially when getting a new dataset or refreshing your memory of an existing
* dataset, this should be your go-to command.




********************************************************************************
**                                  GRAPHING                                  **
********************************************************************************

* One of the best ways for understanding a dataset is to make graphs for its
* various variables. Stata offers a number of graphing commands 


** GRAPHING CATEGORICAL DATA (PIE CHART) -- Pie charts are useful for showing
* how 100% of something are distributed among various categories. A draw-back of
* pie charts is that visual comparison between similarly sized categories is not
* easy -- but otherwise, they are easy to interpret.

* To devide information by categories, Stata uses the over option. In our
* dataset, the variable "priz" contains information about the terrain (flat vs.
* mountainous). Here is a pie chart based on the frequencies of each terrain
* category:
graph pie, over(priz)

* By default, the pie chart comes with a legend if the variable has value labels
* assigned. You can customize the appearance -- see below in this text, or in
* the documentation under
help graph pie

* The abbreviated version of "graph pie" is "gr pie":
gr pie, over(priz)

* You can order the slices from smallest to largest (starting at 12 o'clock and
* going clockwise) by adding the "sort" option:
graph pie, over(priz) sort

* If you prefer to go from largest to smallest, also add "descending":
graph pie, over(priz) sort descending



** GRAPHING CATEGORICAL DATA (BAR CHART) -- Bar charts can fulfill the same task
* for categorial data as pie charts, and have the added advantage that the size
* of similar categories can be more easily perceived.

* The command works the same way as "graph pie":
graph bar, over(priz)

* The abbreviated version of "graph bar" is "gr bar":
gr bar, over(priz)

* If the variable has value labels, they will be used to label the bars for each
* category.

* By default, bar charts have the categories along the x-axis, with bars growing
* upward. The y-axis is labeled in percent for the relative shares of each
* category. If you would like to change the orientation, with the categories
* along the y-axis and percentage along the x-axis, you can use "hbar" instead
* of "bar":
graph hbar, over(priz)

* You can customize the appearance of the bar chart further. See below in this
* text, or in the documentation under
help graph bar


** GRAPHING QUANTITATIVE DATA (HISTOGRAM) -- Histograms are very useful for
* quantitative information because break the entire range of values into
* individual bins and show the frequencies with which observations fall into the
* different bins.

* Our dataset has a variable "totx" which represents the total expenditures of
* households. Creating a histogram for it easy:
histogram totx

* The abbreviated version of "histogram" is "hist":
hist totx

* The histogram will show the entire range and the label of the variable along
* its x-axis. The y-axis is labeled with densities, which are not easy to
* interpret for "normal" earthlings. We recommend switching to percentages or
* frequencies:
histogram totx, percent
histogram totx, frequency

* Later in our course, we'll find that it may be useful to see how "normal"
* a distribution is. Stata allows us to visually inspect this by adding a
* normal distribution to the histogram with the "normal" option:
histogram totx, percent normal

* You can get more documentation on histograms with:
help histogram
* ... and you can customize its appearence (see below!)



** COMPARING QUANTITATIVE DATA BY CATEGORIES (BOX PLOT) -- Box plots are 
* summary graphs that show the distribution of a variable in comparison for
* multiple categories, with indications for the center, central 50% of
* observations, and outliers.

* Our dataset identifies whether a household is located in a rural or urban
* area ("b002"). We can use a boxplot to compare rural and urban household
* expenditures:
graph box totx, over(b002)

* The abbreviated version of "graph box" is "gr box":
gr box totx, over(b002)

* By default, the graph is labeled for each category if the categorical variable
* has value labels, and the range and label of the quantitative variable is
* provided. You can customize the appearance of the graph: see below or read
* the documentation on box plots with:
help graph box



** PLOTTING TWO QUANTITATIVE VARIABLES AGAINST EACH OTHER (SCATTER PLOT) --
* Scatter plots are useful for showing the distribution of two quantitative
* variables in respect to each other.

* Our data contains variables on total household income and expenditures. A
* scatter plot for these two variables is easily created with
graph twoway scatter totx toty

* This command can be abbreviated in many ever-shorter versions:
twoway scatter totx toty
scatter totx toty
tw sc totx toty
sc totx toty
* We like the last one best -- given how frequently we use scatter plots, it's
* fitting to have this command super short.

* By default, the variable listed first will be plotted along the y-axis, and
* variable listed second will be plotted along the x-axis. 

* Especially when you have lots of observations, relatively thick dots for each
* observation may obscure the pattern. You can opt for smaller markers with
sc totx toty, msize(small)

* Not small enough? Go for tiny:
sc totx toty, msize(tiny)

* Stata knows 12 different sizes. You can find a list here:
help markersizestyle

* You can get extensive documentation on scatter plots with:
help scatter

* Scatter plots will come in handy during Econometrics -- we'll be sure to
* revisit this subject...



** CUSTOMIZING AND LABELING YOUR CHARTS --  Stata graphs have sensible default
* options. Usually, the basic command produces a properly labeled, legible
* graph. There are situations where you want or need to fine-tune the settings:
* you may want to adjust the labels to better communicate what the chart shows,
* or you may want to correct default settings in Stata when they don't work well
* for the graph you are producing.

* Often, the most important changes apply to the labeling. We'll start with a
* simple scatter plot:
sc totx toty, msize(tiny)

* and add a title:
sc totx toty, msize(tiny) title("Household Income v Expenditure")

* We can also add subtitles and captions:
sc totx toty, msize(tiny) ///
   title("Household Income v Expenditure") ///
   subtitle("Kyrgyz Integrated Household Survey") ///
   caption("Observations: 4984 households in 2009")
* Because graph commands tend to get longer and longer, here's a trick that
* allows us to break the command over several lines to keep for legibility:
* end each line with \\\ until the command is finished. This only works in do-
* files, not in the command line!

* We can also re-label our axes in the graph in case the variable labels don't
* do a perfect job:
sc totx toty, msize(tiny) ///
   title("Household Income v Expenditure") ///
   subtitle("Kyrgyz Integrated Household Survey") ///
   caption("Observations: 4984 households in 2009") ///
   xtitle("Total Annual Income") ///
   ytitle("Total Annual Expenditures")
   
* Finally, we may want to change the layout and design of the graph. While it is
* possible to change colors, fonts, and positions manually, Stata has a powerful
* option called "scheme" which allows you to apply a consistent design to the
* entire graph. Two popular options are

* ... graphs that match the design used in The Economist:
sc totx toty, msize(tiny) ///
   title("Household Income v Expenditure") ///
   subtitle("Kyrgyz Integrated Household Survey") ///
   caption("Observations: 4984 households in 2009") ///
   xtitle("Total Annual Income") ///
   ytitle("Total Annual Expenditures") ///
   scheme(economist)

* ... and graphs optimized for gray-scale (black and white), low-ink printing:
sc totx toty, msize(tiny) ///
   title("Household Income v Expenditure") ///
   subtitle("Kyrgyz Integrated Household Survey") ///
   caption("Observations: 4984 households in 2009") ///
   xtitle("Total Annual Income") ///
   ytitle("Total Annual Expenditures") ///
   scheme(s1mono)
   
* Stata has 11 default schemes and can install more. Find out more at
help schemes

* All of the graphing commands have many options, far more than we want to cover
* here. Be sure to read the extensive documentation that comes with Stata for
* all of the graph commands by calling the help function:
help graph



** SAVING YOUR GRAPHS -- While you are exploring your data set, just looking at
* different graphs is enough. But as you get closer to writing the report, you
* will want to save graphs. The easiest way is to tack a "saving" option onto
* the end of your graph command
sc totx toty, saving(scatter)

* Unfortunately, this produces a graph in Stata's own file format .gph

* If you want to save a graph for inclusion in your written documents, it's best
* to export the graph in a useful file format. This is done with "graph export":
graph export "scatter.pdf"

* This produces a high-quality PDF version of your graph, which is great for 
* inclusion in Word, LaTeX, PowerPoint, ...

* "graph export" can produce other file types (such png, tiff, eps). You can
* find more here:
help graph export




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




