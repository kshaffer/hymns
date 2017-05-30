library(rvest)
library(tidyverse)
library(stringr)

hymn_data <- read_html('http://hymnary.org/hymn/TH1990/24')

extract_hymn_info <- function(hymn_data) {
  title <- hymn_data %>%
    html_nodes('.hymntitle') %>%
    html_text() %>%
    str_replace('^\\d{0,3}\\. ', '')
  
  text <- hymn_data %>%
    html_nodes('#text') %>%
    html_text() %>%
    str_replace_all('(\\d\\s|\r|\n)', ' ') %>%
    str_replace_all('\\s{2,}', ' ') %>%
    str_replace_all('^ ', '')
  
  if (length(text) == 0) {
    text <- NA
  }
  
  hymn_parsed <- tibble(title = title,
                        text = text)
  
  return(hymn_parsed)
}

hymnal <- tibble()

for (i in 1:100) {
  print(i)
  hymn <- read_html(paste('http://hymnary.org/hymn/TH1990/', i, sep = ''))
  hymnal <- bind_rows(hymnal, extract_hymn_info(hymn))
}

