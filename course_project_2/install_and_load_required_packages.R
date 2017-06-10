## @knitr install_and_load_required_packages

InstallAndLoadRequiredPackages <- function() {
  # Load the required packages.
  if (!require('pacman')) {
    install.packages('pacman')
  }
  pacman::p_load(data.table, dtplyr, stringr, tidyverse)
}

InstallAndLoadRequiredPackages()
