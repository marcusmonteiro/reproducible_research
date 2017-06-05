source('install_and_load_required_packages.R')

data.set.file <- 'payments.csv'

DownloadPaymentsDataSet <- function() {
  # Download the project's data set if the data set directory does not exists.

  if (!file.exists(data.set.file)) {
    data.set.url <- 'https://d3c33hcgiwev3.cloudfront.net/_e143dff6e844c7af8da2a4e71d7c054d_payments.csv?Expires=1496793600&Signature=e9SR4ZhRAgAcje56EtXNYZV6FxtHLDt2xUlznUx8o4MZ2qtsZQXm37xSwgsnUoDWXb7QuEYMdQX4ucyxd--QlRYUsQO8RCfEzlpBO8x26Qp9lhqqBTW~UYooDbF8aoBbIU7hWKd8u8lP62kplhkGB5MiLbUIFnRGoYcRmLE2vxE_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A'
    download.file(data.set.url, data.set.file)
  }
}

ReadPaymentsData <- function() {
  DownloadPaymentsDataSet()

  payments.data <- fread(data.set.file)

  payments.data <- payments.data %>%
    mutate(DRG.Definition = as.factor(DRG.Definition),
           Provider.City = as.factor(Provider.City),
           Provider.State = as.factor(Provider.State),
           Hospital.Referral.Region.Description = as.factor(Hospital.Referral.Region.Description))

  payments.data
}

if (!exists('payments.data')) {
  payments.data <- ReadPaymentsData()
}
