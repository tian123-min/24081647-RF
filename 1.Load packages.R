#Load packages
my_packages = c('ranger', 'ggplot2', 'cowplot', 'data.table', 'tidyverse','pdp', 'ggpubr', 'grf')

for (package in my_packages)  {
  if (!require(package, character.only=T, quietly=T)) {
    install.packages(package)
    library(package, character.only=T)
  }
}
theme_set(theme_cowplot())

