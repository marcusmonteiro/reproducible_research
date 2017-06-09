source('load_storm_data.R')

fatalities.plus.injuries.per.event.type <- storm.data %>%
  group_by(EVTYPE) %>%
  summarise(FATALITIES_PLUS_INJURIES = sum(FATALITIES) + sum(INJURIES))

most.harmful.event.types <- fatalities.plus.injuries.per.event.type %>%
  filter(FATALITIES_PLUS_INJURIES > quantile(FATALITIES_PLUS_INJURIES, probs = 0.97)) %>%
  arrange(desc(FATALITIES_PLUS_INJURIES))

most.harmful.event.types %>%
  ggplot(aes(EVTYPE, FATALITIES_PLUS_INJURIES)) +
  geom_col(aes(fill = FATALITIES_PLUS_INJURIES == max(FATALITIES_PLUS_INJURIES)), show.legend = FALSE) +
  coord_flip() +
  ggtitle('U.S.A, Storm Event Types Most Harmful to Human Health') +
  ylab('Fatalities Plus Injuries') +
  xlab('Event Type')

