source('install_and_load_required_packages.R')

ReadStormData <- function() {
  storm.data.url <- 'https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2'

  storm.data.filename <- 'StormData.csv.b2z'

  if (!file.exists(storm.data.filename)) {
    download.file(storm.data.url, storm.data.filename)
    download.file('https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf',
                  'StormData_documentation.pdf',
                  mode = 'wb')
    download.file('https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2FNCDC%20Storm%20Events-FAQ%20Page.pdf',
                  'StormData_faq.pdf',
                  mode = 'wb')
  }

  read.csv(storm.data.filename)
}

if (!exists('storm.data')) {
  storm.data <- ReadStormData()
}
