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




