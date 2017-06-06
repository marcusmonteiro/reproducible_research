source('load_payments_data.R')

MakePlot1 <- function() {
  new.york.payments.data <- payments.data %>%
    filter(Provider.State == 'NY')

  new.york.payments.data %>%
    select(Average.Covered.Charges, Average.Total.Payments) %>%
    plot

  with(new.york.payments.data, abline(lm(Average.Total.Payments ~ Average.Covered.Charges)))

  with(new.york.payments.data, text(
    x = (max(Average.Covered.Charges, na.rm = TRUE) + min(Average.Covered.Charges, na.rm = TRUE)) / 2,
    y = 30000,
    labels = paste('Correlation:', round(cor(Average.Covered.Charges, Average.Total.Payments), digits = 2))
  ))
}

MakePlot1()
