//Commands for Gini Coefficients  and Lorenz Curves!
//I found these while making my report.

//glcurve "generate lorenz curve" creates a lorenz line graph 
//of the data selected. The Lorenz curve is a visualisation of 
//inequality among the data set. It is usually used for incomes
//to measure income inequality. It's essentially a cumulative frequency
//plot.

//A perfeclty equal distribution of incomes is closer and closer
//to the line. A perfectly unequal society (where all bar one have
//nothing, and that one guy has *all the things*) appears as a vertical
//line towards the right-hand side of the plot.

//These are integral to generating a gini coefficient.

//Fastgini is intended for generating gini coefficients for large data
//sets, but the underlying formula is the standard one.
//The Gini Coefficient of a set of incomes is a function of the difference
//between a perfectly even distribution and a lorenz curve, ranging from
//0:perfeclty equal-- everyone has the same amount
//1:perfeclty unequal-- one person has everything.
//The Coefficient is multiplied by 100 to create the Gini Index, as found
//here: http://data.worldbank.org/indicator/SI.POV.GINI

net install gr0001_3
net install fastgini.pkg

// When installed type...

help fastgini
help glcurve

//... for details. Enjoy!
