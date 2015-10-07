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




