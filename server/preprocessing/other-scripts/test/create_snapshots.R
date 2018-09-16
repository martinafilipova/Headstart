### FOR BASE

rm(list = ls())

library(rstudioapi)
library(jsonlite)

options(warn=1)

wd <- dirname(rstudioapi::getActiveDocumentContext()$path)

setwd(wd) #Don't forget to set your working directory

query <- "digital education" #args[2]
service <- "base"
params <- NULL
params_file <- "snapshot_params_base.json"

source('../utils.R')
source("../vis_layout.R")
source('../base.R')

DEBUG = FALSE

MAX_CLUSTERS = 15
ADDITIONAL_STOP_WORDS = "english"

if(!is.null(params_file)) {
  params <- fromJSON(params_file)
}

#start.time <- Sys.time()

input_data = get_papers(query, params, limit=120)
write_json(input_data, "snapshots/snapshot_base_input.json")
#end.time <- Sys.time()
#time.taken <- end.time - start.time
#time.taken

output_json = vis_layout(input_data$text, input_data$metadata, max_clusters=MAX_CLUSTERS,
                         add_stop_words=ADDITIONAL_STOP_WORDS, testing=TRUE, list_size=100)

write_json(data.frame(fromJSON(output_json)), "snapshots/snapshot_base_expected.json")


### FOR PUBMED

rm(list = ls())

library(rstudioapi)
library(jsonlite)

options(warn=1)

wd <- dirname(rstudioapi::getActiveDocumentContext()$path)

setwd(wd) #Don't forget to set your working directory

query <- "health education" #args[2]
service <- "pubmed"
params <- NULL
params_file <- "snapshot_params_pubmed.json"

DEBUG = FALSE

source('../utils.R')
source("../vis_layout.R")
source('../pubmed.R')

MAX_CLUSTERS = 15
ADDITIONAL_STOP_WORDS = "english"

if(!is.null(params_file)) {
  params <- fromJSON(params_file)
}

#start.time <- Sys.time()

input_data = get_papers(query, params)
write_json(input_data, "snapshots/snapshot_pubmed_input.json")
#end.time <- Sys.time()
#time.taken <- end.time - start.time
#time.taken

output_json = vis_layout(input_data$text, input_data$metadata, max_clusters=MAX_CLUSTERS,
                         add_stop_words=ADDITIONAL_STOP_WORDS, testing=TRUE)
write_json(data.frame(fromJSON(output_json)), "snapshots/snapshot_pubmed_expected.json")