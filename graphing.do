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




