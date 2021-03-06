# ----------------------------------------------------------------------------------------
# R Script to auto-select and train the Deep Learning model on Financial Asset Time Series Data
# ----------------------------------------------------------------------------------------
# (C) 2018 Vladimir Zhbanko
# https://www.udemy.com/self-learning-trading-robot/?couponCode=LAZYTRADE7-10
# Script to gather financial data, transform it and to perform
# Supervised Deep Learning Classification Modelling
#
# load libraries to use and custom functions
library(tidyverse)
library(h2o)
library(lubridate)
library(magrittr)
#library(plotly)
source("D:/TradingRepos/R_selflearning/load_data.R")
source("D:/TradingRepos/R_selflearning/create_labelled_data.R")
source("D:/TradingRepos/R_selflearning/create_transposed_data.R")
source("D:/TradingRepos/R_selflearning/self_learn_ai.R")
source("D:/TradingRepos/R_selflearning/self_learn_ai_R.R")
source("D:/TradingRepos/R_selflearning/test_model.R")

#absolute path to store model objects (useful when scheduling tasks)
path_model <- "D:/TradingRepos/R_selflearning/model"

#### Read asset prices and indicators ==========================================
# load prices of 28 currencies
prices <- load_data(path_terminal = "D:/FxPro - Terminal3/MQL4/Files/",
                    trade_log_file = "AI_CP", 
                    time_period = 15,
                    data_deepth = "35000")

# load macd indicator of 28 currencies
macd <- load_data(path_terminal = "D:/FxPro - Terminal3/MQL4/Files/",
                  trade_log_file = "AI_Macd", 
                  time_period = 15,
                  data_deepth = "35000")

# to be used for tests of demonstrations
# prices <- read_rds("test_data/prices.rds")
# macd <- read_rds("test_data/macd.rds")

h2o.init()
# # performing Deep Learning classification using the custom function
# self_learn_ai(price_dataset = prices,
#               indicator_dataset = macd,
#               num_bars = 75,
#               timeframe = 15,
#               path_model = path_model,
#               write_log = TRUE)

# performing Deep Learning Regression using the custom function
self_learn_ai_R(price_dataset = prices,
                indicator_dataset = macd,
                num_bars = 75,
                timeframe = 15,
                path_model = path_model,
                write_log = TRUE)
h2o.shutdown(prompt = F)

# update trigger in the sandboxes
# read trigger value to the repository and paste it to the sandboxes
file.copy(from = file.path(path_model, "LOG", "AI_T-15.csv"), 
          to = c("D:/FxPro - Terminal1/MQL4/Files/AI_T-15.csv",
                 "D:/FxPro - Terminal2/MQL4/Files/AI_T-15.csv",
                 "D:/FxPro - Terminal3/MQL4/Files/AI_T-15.csv"),
          overwrite = TRUE) 


#### End