## Anonymous
# 
## Script date: 

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("stm")){install.packages("stm", dependencies = TRUE); require("stm")}

# Load stm model ---------------------------------------------------------------

load("stm.RData")

# Estimate effects for topic 3
prep_effect <- estimateEffect(1:4 ~ condition * model, 
                              stmobj = stm_model,
                              metadata = out$meta,
                              uncertainty = "Global")

# Get just the condition effect for topic 3
condition_effect <- summary(prep_effect, topics = 3)

condition_effect
