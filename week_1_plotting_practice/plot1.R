source('load_payments_data.R')

MakePlot1 <- function() {
  new.york.payments.data <- payments.data %>%
    filter(Provider.State == 'NY')

  new.york.payments.data %>%
    select(Average.Covered.Charges, Average.Total.Payments)
}

MakePlot1()
