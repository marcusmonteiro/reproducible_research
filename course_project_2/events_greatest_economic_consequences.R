## @knitr events_greatest_economic_consequences

ExpToMultiplier <- function(e) {
  e <- tolower(e)
  if (e == '?' | e == '+' | e == '-') {
    return(0)
  }
  if (e == 'h') {
    return(10 ^ 2)
  }
  if (e == 'k') {
    return(10 ^ 3)
  }
  if (e == 'm') {
    return(10 ^ 6)
  }
  if (e == 'b') {
    return(10 ^ 9)
  }
  10 ^ as.numeric(e)
}

damage.by.event.type <- storm.data %>%
  mutate(PROPDMG_IN_DOLLARS = PROPDMG * sapply(PROPDMGEXP, ExpToMultiplier),
         CROPDMG_IN_DOLLARS = CROPDMG * sapply(CROPDMGEXP, ExpToMultiplier)) %>%
  group_by(EVTYPE) %>%
  summarise(TOTAL_DAMAGE_IN_DOLLARS = sum(PROPDMG_IN_DOLLARS, na.rm = TRUE) + sum(CROPDMG_IN_DOLLARS, na.rm = TRUE))

events.greatest.economic.consequences <- damage.by.event.type %>%
  filter(TOTAL_DAMAGE_IN_DOLLARS > quantile(TOTAL_DAMAGE_IN_DOLLARS, probs = 1 - 1/100)) %>%
  arrange(desc(TOTAL_DAMAGE_IN_DOLLARS))

events.greatest.economic.consequences %>%
  ggplot(aes(reorder(EVTYPE, TOTAL_DAMAGE_IN_DOLLARS), TOTAL_DAMAGE_IN_DOLLARS)) +
  geom_col() +
  coord_flip() +
  ggtitle('U.S.A, Top 1% Storm Type Events in Economic Damage') +
  ylab('Total Damage in U.S. Dollars (Property + Crop)') +
  xlab('Event Type')
