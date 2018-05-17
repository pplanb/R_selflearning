# ----------------------------------------------------------------------------------------
# R Script to auto-select and train the Deep Learning model on Financial Asset Time Series Data
# ----------------------------------------------------------------------------------------
# (C) 2018 Vladimir Zhbanko
# https://www.udemy.com/draft/1482480/?couponCode=LAZYTRADE7-10
# Script to gather financial data, transform it and to perform
# Supervised Deep Learning Classification Modelling
#
# load libraries to use and custom functions
library(tidyverse)
library(h2o)
library(lubridate)
library(magrittr)
#library(plotly)
source("C:/Users/fxtrams/Documents/000_TradingRepo/R_selflearning/load_data.R")
source("C:/Users/fxtrams/Documents/000_TradingRepo/R_selflearning/create_labelled_data.R")
source("C:/Users/fxtrams/Documents/000_TradingRepo/R_selflearning/create_transposed_data.R")
source("C:/Users/fxtrams/Documents/000_TradingRepo/R_selflearning/self_learn_ai.R")

#### Read asset prices and indicators ==========================================
# load prices of 28 currencies
prices <- load_data(path_terminal = "C:/Program Files (x86)/FxPro - Terminal2/MQL4/Files/",
                    trade_log_file = "AI_CP", 
                    time_period = 15)

# load macd indicator of 28 currencies
macd <- load_data(path_terminal = "C:/Program Files (x86)/FxPro - Terminal2/MQL4/Files/",
                  trade_log_file = "AI_Macd", 
                  time_period = 15)

# to be used for tests of demonstrations
# prices <- read_rds("test_data/prices.rds")
# macd <- read_rds("test_data/macd.rds")

# performing Deep Learning classification using the custom function
self_learn_ai(price_dataset = prices,
              indicator_dataset = macd,
              num_bars = 100,
              timeframe = 15)

# performing Deep Learning Regression using the custom function
self_learn_ai_R(price_dataset = prices,
                indicator_dataset = macd,
                num_bars = 100,
                timeframe = 15)
#### End