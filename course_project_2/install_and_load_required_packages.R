InstallAndLoadRequiredPackages <- function() {
  # Load the required packages.
  if (!require('pacman')) {
    install.packages('pacman')
  }
  pacman::p_load(data.table, dtplyr, tidyverse)
}

InstallAndLoadRequiredPackages()
