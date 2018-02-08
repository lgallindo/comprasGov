usethis::use_mit_license("Lucas Gallindo")
# To-Do: Import only the %>% symbol
usethis::use_package("magrittr", "Depends")
usethis::use_package("dplyr", "Imports")
usethis::use_package("openxlsx", "Imports")
usethis::use_package("curl", "Imports")

devtools::use_data_raw()
devtools::use_data()

knownModules <- c("pregoes")
knownMethods <- openxlsx::read.xlsx(xlsxFile = "data-raw/knownMethods.xlsx")
knownFormats <- c("html", "xml", "json", "csv")

devtools::use_data(knownModules)
devtools::use_data(knownMethods)
devtools::use_data(knownFormats)

returnValues <- openxlsx::read.xlsx(xlsxFile = "data-raw/returnValues.xlsx")

devtools::use_data(returnValues)
