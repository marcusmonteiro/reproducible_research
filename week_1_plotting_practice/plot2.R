source('load_payments_data.R')

MakePlot2 <- function() {
  # Don't know how to do this with base R graphics yet, Lol
  payments.data %>%
    ggplot(aes(Average.Covered.Charges, Average.Total.Payments)) +
    facet_wrap(Provider.State ~ DRG.Definition) +
    geom_point() +
    geom_smooth(method = 'lm') +
    ggtitle(label = 'Medicare Data, by State and Medical Condition') +
    xlab('Average Covered Charges') +
    ylab('Average Total Payments')

  ggsave('plot2.pdf', scale = 3)
}

MakePlot2()
