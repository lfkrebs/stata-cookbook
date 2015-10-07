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




