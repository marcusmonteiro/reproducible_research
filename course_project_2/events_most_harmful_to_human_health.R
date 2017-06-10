## @knitr events_most_harmful_to_human_health

fatalities.per.event.type <- storm.data %>%
  group_by(EVTYPE) %>%
  summarise(FATALITIES = sum(FATALITIES)) %>%
  mutate(PERCENTAGE_OF_FATALITIES = FATALITIES / sum(FATALITIES))

most.fatalities.event.types <- fatalities.per.event.type %>%
  filter(FATALITIES > quantile(FATALITIES, probs = 1 - 1/100)) %>%
  arrange(desc(FATALITIES))

injuries.per.event.type <- storm.data %>%
  group_by(EVTYPE) %>%
  summarise(INJURIES = sum(INJURIES)) %>%
  mutate(PERCENTAGE_OF_INJURIES = INJURIES / sum(INJURIES))

most.injuries.event.types <- injuries.per.event.type %>%
  filter(INJURIES > quantile(INJURIES, probs = 1 - 1 / 100)) %>%
  arrange(desc(PERCENTAGE_OF_INJURIES))

most.fatalities.event.types %>%
  ggplot(aes(reorder(EVTYPE, PERCENTAGE_OF_FATALITIES), PERCENTAGE_OF_FATALITIES)) +
  geom_col() +
  coord_flip() +
  ggtitle('U.S.A, Top 1% Storm Type Events in Human Fatalities') +
  ylab('Percentage of All Human Fatalities') +
  xlab('Event Type')

most.injuries.event.types %>%
  ggplot(aes(reorder(EVTYPE,PERCENTAGE_OF_INJURIES), PERCENTAGE_OF_INJURIES)) +
  geom_col() +
  coord_flip() +
  ggtitle('U.S.A, Top 1% Storm Type Events in Human Injuries') +
  ylab('Percentage of All Human Injuries') +
  xlab('Event Type')
