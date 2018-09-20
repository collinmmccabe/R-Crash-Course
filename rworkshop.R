################################################################################
#                                                                              #
#                         Math to Industry R Workshop                          #
#                                 ------------                                 #
#                                  09/19/2018                                  #
#                                 ------------                                 #
#                 Collin McCabe | collinmichaelmccabe@gmail.com                #
#                                                                              #
################################################################################

#------#
# Math #
#------#

# At it's heart, R is just a big calculator...

# Addition
1 + 2

# Subtraction
2 - 1

# Multiplication
2 * 3

# Division
4 / 2

# Exponents
3 ^ 2

# Modulo (a.k.a. Remainder)
5 %% 2

# Integer (Floor) Division
5 %/% 2

#-----------#
# Variables #
#-----------#

# Variables are an easy way to store pretty much anything that you may want to
# use later in your code. You can use the equal sign for this:
x = 42

# However, the preferred notation for variable assignment in R is <-
# This is because, by default, the item on the right is always assigned to
# the item on the left. The arrow allows you to keep track of this better
y <- 10

# You can see what's stored in the variable by typing the variable name by 
# itself
y

# When you have a variable, you can do anything with it that you could with the
# original value
x + 10
x + y

# And we can assign the results of operations directly to new variables
# (you can name variables anything you want, with some exceptions, including:
# no spaces, no quotation marks, no operators like +-/*^%><=!)
My_Variable <- 10 + y

#-------#
# Types #
#-------#

# Variables can be of many different types, or classes, in R:

# Null
i <- NULL
class(i)

# Numeric
j <- 2
class(j)

# Integer (must be stated strictly)
k <- as.integer(4)
class(k)

# Logical (True or False, a.k.a. Boolean)
l <- TRUE
class(l)

# Character
m <- "a"
class(m)

#-----------#
# Functions #
#-----------#

# R is primarily a functional programming language - the majority of things that
# you do, you will do with a function. Functions are operations that take a 
# variable as an input and return a value after doing something to it.
z <- -20
abs(z)

# But inputting a variable to a function will leave the original value unchanged
# (with only a few very rare exceptions):
z

# If you would like to save the output of a function, store the output of the 
# function in a new variable:
z_new <- abs(z)
z_new

#-----------------#
# Data Structures #
#-----------------#

# Variables or values can be stored in a variety of structures. The two most 
# common structures that will be used in R are vectors and data frames.

# Vectors are 1-dimensional arrays of values of the same type. They are created
# using the c() function to concatenate values:
vec <- c(2, 5, 4, 7, 9, 24, 62)
other_vec <- c(5, 4, 6, 20, 41, 12, 9)

# Vectors can hold any type of value- for instance, characters/strings
char_vec <- c("first", "second", "third", "fourth", "fifth", "sixth", "seventh")
class(vec); class(char_vec) 

# You can pull out single values of vectors by refering to their index with []
# ...but it's important to note that in R, everything is indexed starting at 1,
# whereas in many other programming languages, things are indexed starting at 0:
vec[1]
vec[0]

# Many functions take vectors as their arguments
mean(vec)
sum(vec)
sd(vec)

# Data frames are essentially matrices where each column may be of a different
# type/class; i.e. they are two-dimensional, heterogeneous arrays. These are
# typically the structures that most R data scientists use for interacting with
# data, as they allow a variety of information to be stored in the same object

# We can turn vectors into columns of a data frame using the data.frame()
# function and listing "name = vector" for each column, separated by commas
data.frame(first_col = vec, second_col = other_vec, third_col = char_vec)

# But rather than build a dataset from scratch, we'll work with a pre-loaded
# data frame that came with your base R installation: the USArrests dataset - 
# no need to save it as a new object, it's already here
USArrests

# Indexing and appending values for data frames are similar to that for vectors
# except, instead of indexing one dimension, you index two with df[row, column]
USArrests[3, 2]

# Leaving one of these fields empty will return the entire row or column that 
# has been specified:
USArrests[, 2]

# But an easier way to refer to columns specifically in data frames is to use
# the $ between the name of the data fram and the name of the column:
USArrests$Assault

#----------------#
# Importing Data #
#----------------#

# If you want to do analysis on your own data, you'll probably need to read some
# sort of external file into R.  The two most common formats for external data 
# are either comma separated (csv file) or tab delimited (usually just txt 
# files). Delimitting is just a fancy term for saying "using a standard 
# placemarker for separating entries. If you are working in Excel, when you go 
# to "Save As" you can choose either of these formats from the file type
# dropdown menu.

# Let's start with tab-delimitted (data fields separated by a \t or tab)
# files. Using R, you import these files with read.table(). In order for
# our column names didn't get read in correctly. We can fix that with the 
# argument, header = TRUE
read.table("data/usbls_edhcemployment_short.txt", header = TRUE)

# But we will need to save the output of this read function to a variable name 
# if we want to do anything with it.
empdata <- read.table("data/usbls_edhcemployment_short.txt", header = TRUE)

# We can also read in comma-separated value files using the function read.csv()
# read.csv() expects column names, and so we need to explicitly state that we
# don't have any column names in this file, and that our first line contains
# data
cardata <- read.csv("data/car.csv", header = FALSE)

# Using the head() function will allow us to see the first few lines of our data
# without having to print it all to the terminal.
head(cardata)

# But for the rest of the workshop, we will use the iris dataset, which comes
# preinstalled with R:
head(iris)

#---------------#
# Visualization #
#---------------#

# Before diving into analyses, it's best to make some graphs and see what the 
# patterns are in your data. This is commonly refered to as "Exploratory Data
# Analysis".

# We may want to see how a given numerical variable is distributed, and for this
# our best bet would be a histogram
hist(iris$Sepal.Length)

# Or maybe we want to compare the distributions of many different groups at once
# - then we would want to use a boxplot. The syntax for boxplots is: 
# boxplot(numerical_column ~ categorical_column)
boxplot(iris$Sepal.Length ~ iris$Species)

# But if we are instead interested in comparing two numerical variables to see 
# if they may be correlated, we would use a scatterplot. The same syntax as for
# boxplots holds for scatterplots, except that both columns are numerical:
plot(iris$Petal.Length ~ iris$Petal.Width)

# For large datasets with many numerical variables, it might be good to look at
# all pairwise combinations of variables during exploratory data analysis:
pairs(iris)

#------------#
# Statistics #
#------------#

# Once we have a good sense of what patterns there may be in the data, we can go
# about testing whether or not these patterns are statistically "significant",
# or unlikely to have arisen by chance. The most basic and most common indicator
# of significance in statistics is the p-value, which indicates how likely it
# is that a given pattern arose by chance; the typical cutoff for significance 
# is 0.05

# If we want to test if the numerical values (specifically, the means) of two
# groups are significantly different, we would use the t-test. Just as with the
# boxplot, the first variable is the numerical one, and the second is the 
# catregorical, but now there is another argument after the comma - this is the
# data set (since t-tests can only compare two groups, I've removed one of the
# specis from the dataset for this test).
t.test(Petal.Length ~ Species, iris[iris$Species != "versicolor", ])

# If instead, we want to know if there is a significant relationship between two
# numerical variables, we would use a linear regression model to estimate how 
# likely the slope of the line formed by their scatterplot is to have arisen by
# chance (i.e. the p-value). In addition to the p-value, linear regressions also
# describe how tightly a line fits the points of the scatterplot (this is called
# the R-square value). A good model should have a high R-square and low p-value.
# for these linear regressions, syntax is again the same as for the categorical
# version: (variable ~ variable, dataset):
lm(Petal.Length ~ Petal.Width, iris)

# But in order to display the p-value and R-square, we will need to print the 
# summary of the model:
summary(lm(Petal.Length ~ Petal.Width, iris))

#---------------------#
# And so much more... #
#---------------------#

# We've only scratched the surface of what R can do! If you're interested in 
# learning more, there are lots of great resources in the presentation...
