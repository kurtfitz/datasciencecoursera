##  Getting and Cleaning Data Week 1 Notes



Goal of course:

The general pipeline in data analysis or machine learning looks something like this:

Raw data -> Processing Script -> tidy data -> data analysis -> data communication

Often courses leave out the step of processing and producing tidy data, which ends up having performance implications later on in the pipeline.



#### Raw and processed data

##### Data - values of qualitative or quantitative variables, belonging to a set of items.

Qualitative - country, origin, gender

Quantitative - blood pressure, height, age, weight

##### Raw Data

- original source of the data
- often hard to use for data analysis
- Data analysis includes processing

##### Processed Data

- Data that is ready for analysis
- Processing can include merging, subsetting, transforming, etc..
- All steps should be recorded



#### Components of tidy data

There are four things you should have when going from a  raw data set to a tidy one:

- The raw data

- A tidy data set

- A  code book describing each variable and it's values in the tidy data set

- An explicit and exact recipe you used to go from 1-2,3

  ​

The Raw Data

You know the data is in the right format if you

1. Ran no software on the data
2. Did not manipulate any of the numbers in the data
3. you did not remove any data from the data set
4. You did no summarize the data in any way

Tidy Data

1. Each variable you measure should be in one column
2. Each differed observation should be in a different row
3. There should be one table for each kind of variable
4. If you have multiple tables, they should include a column in the table that allows them to be linked

Tips

- Include a row at the of each file with variable names (human readable)
- Save data in one file per table



Code Book

1. Info about the variables (units)
2. Info about the summary choices you made
3. Info about the experimental study design you used

Tips

- common format for this document is Word/text file.
- Section called code book with each variable and units

Instruction List

- ideally a computer script (R or python)
- The input for the script is the raw data
- The output is processed, tidy data
- There are no parameters to the script*



##### Downloading Files

Get/set your working directory

- basic component of working with data is know working directory
- two main commands are getwd() and setwd()
- Be aware of relative versus absolute paths
- important distinction in Windows: setwd("C:\\Users\\\Kurt\\Downloads")

Checking for and creating directories

- file.exists("dirName") - returns bool


- dir.create("dirName")

Getting data from the internet

- download.file()
- params, url, destfile, method
- useful for getting tab-delimited, csv, and other files

##### Loading Local Files

- read.table() is the main function for reading data into R

- Flexible and robust but requires more params

- Reads the data into RAM

- params, file, header, sep, row.names, nrows

- Related: read.csv(), read.csv2()

  ​

##### Reading Local Files

Important params for reading in files

- quote - you can tell R whether there are any quoted values quote = "" means no quotes
- na.strings - set the character that represents a missing value
- nrows - how many rows to read of the file (nrows = 10 reads 10 lines)
- skip - number of lines to skip before starting to read



##### Reading Excel Files

- library(xlsx)
- data <- read.xlsx("fileName", sheetIndex=1, header=TRUE)

Reading specific rows and columns

- colIndex <- 2:3
- rowIndex <- 1:4
- data <- read.xlsx("fileName", sheetIndex=1, colIndex=colIndex, rowIndex=rowIndex)

Tips

- write.xlsx to write out to Excel files

- read.xlsx2 is much faster 

- XL Connect is more flexible and has more options

- XLConnect vignette is a good resource

- It general it's easier to use csv files then Excel Files

  ​

##### Reading XML

- Extensible markup language
- Frequently used to store structured data
- Particularly wide  used in  internet
- Components
  - Markup - labels
  - Content - actual content
  - Tags, element, and attributes
- library(XML)
- fileUrl <- "http://www.w3schools.com/xml/simple.xml"
- doc <- xmlTreeParse(fileUrl, useInternalNodes =TRUE)
  - ** The second parameter is required in most cases
- rootNode  <- xmlRoot(doc) - Get the wrapping node
- xmlName(rootNode)
-  Access elements in xml doc:  rootNode[[1]]



###### Programmatically extract parts of the file

- xmlSApply(rootNode,  xmlValue) - Pass is a parsed xml tree, and then root through all of the properties of the root node and  get their values.

- XPath is a language that allows to manipulate XML documents

  - /node Top level node
  - //node Node at any level
  - node[@attr-name] Node with an attribute name
  - node[@attr-name='bob'] Node with attribute name bob

  eg) xpathSApply(rootNode, "//name", xmlValue) - get nodes that  correspond to an element name and get the xml value of those nodes.

  ###### Cool Web Scraping Example - Get teams and scores from web site

  fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravnes"

  doc <- htmlTreeParse(fileUrl, useInternal= TRUE)

  scores <- xPathSApply(doc, "//li[@class='score']", xmlValue)

  teams <- xpathSApply(doc, "//li@class='team-name']", xmlValue)

  scores

  teams



#### Reading JSON

- library(jsonlite)
- jsonData <- fromJSON("https://someurl")
- names(jsonData)
- Writing data frames to JSON
  - myjson <- toJSON(iris, pretty=TRUE)
  - cat(myjson)
  - Convert back to JSON
    - iris2 <- fromJSON(myjson)
    - head(iris2)



#### Data.table package

- inherits from data.frame
- Written is C, so it's much faster (sub-setting, group, updating)
- ​