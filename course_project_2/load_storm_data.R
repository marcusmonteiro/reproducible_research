## @knitr data_processing

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

RenameEqualEvTypes <-function(storm.data) {
  storm.data <- storm.data %>%
    mutate(EVTYPE = toupper(EVTYPE))

  # Consolidates based on: https://en.wikipedia.org/wiki/Severe_weather_terminology_(United_States)
  # Marine events have special treatment
  storm.data[str_detect(storm.data$EVTYPE, 'TSTM|THUNDERSTORM') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL'), ]$EVTYPE <- 'THUNDERSTORM'

  storm.data[str_detect(storm.data$EVTYPE, 'TORNADO') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL|WATER'), ]$EVTYPE <- 'TORNADO'

  storm.data[str_detect(storm.data$EVTYPE, 'MARINE THUNDER|SEA THUNDER|MARINE TSTM|SEA TSTM'),
             ]$EVTYPE <- 'MARINE THUNDERSTORM'

  storm.data[str_detect(storm.data$EVTYPE, 'WINTER') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL|STORM|SNOW'),
             ]$EVTYPE <- 'WINTER WEATHER'

  storm.data[str_detect(storm.data$EVTYPE, 'WINTER STORM') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL|SNOW'), ]$EVTYPE <- 'WINTER STORM'

  storm.data[str_detect(storm.data$EVTYPE, 'BLIZZARD') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL|HEAVY'), ]$EVTYPE <- 'BLIZZARD'

  storm.data[str_detect(storm.data$EVTYPE, 'HEAVY SNOW') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL|STORM|ICE'), ]$EVTYPE <- 'HEAVY SNOW'

  storm.data[str_detect(storm.data$EVTYPE, 'LAKE-EFFECT SNOW') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL'), ]$EVTYPE <- 'LAKE-EFFECT SNOW'

  storm.data[str_detect(storm.data$EVTYPE, 'FREEZING RAIN') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL'), ]$EVTYPE <- 'FREEZING RAIN'

  storm.data[str_detect(storm.data$EVTYPE, 'ICE STORM') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL'), ]$EVTYPE <- 'ICE STORM'

  storm.data[str_detect(storm.data$EVTYPE, 'TROPICAL STORM') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL'), ]$EVTYPE <- 'TROPICAL STORM'

  storm.data[str_detect(storm.data$EVTYPE, 'HURRICANE') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL'), ]$EVTYPE <- 'HURRICANE'

  storm.data[str_detect(storm.data$EVTYPE, 'FLOOD') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|FLASH|COASTAL|LAKE|RIVER|URBAN|SMALL|STREET'),
             ]$EVTYPE <- 'FLOOD'

  storm.data[str_detect(storm.data$EVTYPE, 'FLASH FLOOD') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL|LAKE|RIVER|URBAN|SMALL|STREET'),
             ]$EVTYPE <- 'FLASH FLOOD'

  storm.data[str_detect(storm.data$EVTYPE, 'COASTAL FLOOD|COAST FLOOD|MARINE FLOOD|SEA FLOOD') &
               !str_detect(storm.data$EVTYPE, 'NON|LAKE|RIVER|URBAN|SMALL|STREET'),
             ]$EVTYPE <- 'COASTAL FLOOD'

  storm.data[str_detect(storm.data$EVTYPE, 'LAKESHORE FLOOD|LAKE FLOOD') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL|RIVER|URBAN|SMALL|STREET'),
             ]$EVTYPE <- 'LAKESHORE FLOOD'

  storm.data[str_detect(storm.data$EVTYPE, 'RIVER FLOOD') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL|LAKE|URBAN|SMALL|STREET'),
             ]$EVTYPE <- 'RIVER FLOOD'

  storm.data[str_detect(storm.data$EVTYPE, 'URBAN FLOOD|STREET FLOOD|SMALL STREAM FLOOD|SMALL FLOOD') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL'),
             ]$EVTYPE <- 'URBAN AND SMALL STREAM FLOOD'

  storm.data[str_detect(storm.data$EVTYPE, 'HEAT') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL'), ]$EVTYPE <- 'EXCESSIVE HEAT'

  storm.data[str_detect(storm.data$EVTYPE, 'CHILL') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL|COLD'), ]$EVTYPE <- 'WIND CHILL'

  storm.data[str_detect(storm.data$EVTYPE, 'COLD') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL|CHILL'), ]$EVTYPE <- 'EXTREME COLD'

  storm.data[str_detect(storm.data$EVTYPE, 'FREEZE') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL'), ]$EVTYPE <- 'FREEZE'

  storm.data[str_detect(storm.data$EVTYPE, 'MARINE STORM|SEA STORM|COASTAL STORM') &
               !str_detect(storm.data$EVTYPE, 'NON'), ]$EVTYPE <- 'COASTAL STORM'

  storm.data[str_detect(storm.data$EVTYPE, 'HIGH SURF') &
               !str_detect(storm.data$EVTYPE, 'NON'), ]$EVTYPE <- 'HIGH SURF'

  storm.data[str_detect(storm.data$EVTYPE, 'HIGH WIND') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL'), ]$EVTYPE <- 'HIGH WIND'

  storm.data[str_detect(storm.data$EVTYPE, 'HEAVY RAIN') &
               !str_detect(storm.data$EVTYPE, 'NON|MARINE|SEA|COASTAL'), ]$EVTYPE <- 'HEAVY RAIN'

  storm.data
}

if (!exists('storm.data')) {
  storm.data <- ReadStormData()
  storm.data <- RenameEqualEvTypes(storm.data)
}
