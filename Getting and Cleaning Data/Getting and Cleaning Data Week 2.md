# Getting and Cleaning Data Week 2: MySQL

### Connecting to hg19 and listing tables

```R
hg19 <- dbConnect(MySQL(), user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5] (list first 5 tables)
dbListFields(hg19, "affyU133Plus2") (Show columns names of given table)
dbGetQuery(hg19, "select count(*) from afftu133Plus2") (get the row count)
affyData <- dbReadTable(hg19, "affyu133Plus2") (get table data into dataframe)
dbSendQuery(hg19, "select * from affyuh33Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)
dbDisconnect(hg19) (Remember to close your connection when you are done)



```



### Reading Data From HDF5

- Used for storing large data sets
- Supports storing a range of data types
- Heirarchical data format
- ​



###  Reading Data from the Web

#### Webscraping:

Programmatically extracting data from the HTML code of websites

- many websites have information you may want to programmatically read

- In some cases this is against the terms of service for the website

  Example: 

  Getting data off webpages - readLines()

```R
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

```

### Parsing with XML

```
library(XML)
url <= "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)

```



### GET from the httr package

```R
library(httr); html2 = GET(url)
content2 = content(html2, as="text")
parsedHhtml = htmlParse(content2, asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)
```

### Accessing websites with passwords

```R
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1
Will get a 401 error
can use httr package to authenticate
pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
         authenticate("user", "passwd"))

```

#### Using Handles

```
google = handle("http://google.com")
pg1 = GET(handle=google, path="/")
```



## Reading from APIs

Lots of Demo's here:

https://github.com/r-lib/httr/tree/master/demo





2013-11-07T13:25:07Z

sqldf("select pwgtp1 from acs where AGEP < 50")

sqldf("select distinct AGEP from acs")

45 31 7 25

36.5