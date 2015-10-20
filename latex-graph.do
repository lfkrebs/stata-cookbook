*********************************************************************
*                   Exporting Graphs to LaTeX                       *
*********************************************************************

**The command graph2tex exports any graph and provides a text file which you just
**need to copy from Stata into your LateX file. But first things first:


*** Preparation *****************************************************
**First you need to install the graph2tex package. Find it with the command
findit graph2tex
**and click on install package

**in your latex file you must add
* \usepackage{epsfig}
** into your header (without the '*' of course)

*** Exporting graphs to LaTeX **************************************
**  First you need to create a graph. For example
graph pie, over(priz) pl(_all per)
**  then export the graph
graph2tex, epsfile(yourfilename)
**  Stata saves the file in the working directoy as 'yourfilename.eps'
**  copy that .eps file into the directory where you have your latex file 
**  (or vice versa)
**  State also gives you a few lines of code which you just need to copy-paste 
**  into your LaTeX file. The default would look like this
* \begin{figure}[h]
* \begin{centering}
* \includegraphics[height=3in]{yourfilename}
* \end{centering}
* \end{figure}

*** Options ******************************************************** 
**  You can add a caption to the graph to be included in Latex. For example
graph pie, over(priz) pl(_all per)
graph2tex, epsfile(areatype_pie) caption(Area Types)

**  You can also add a label to your LaTex code
graph pie, over(priz) pl(_all per)
graph2tex, epsfile(areatype_pie) caption(Area Types) label(my_label)

**  To modify the height of the graph us the ht() option for example
graph pie, over(priz) pl(_all per)
graph2tex, epsfile(areatype_pie) caption(Area Types) ht(4)
