
## Anonymous
# 

## Script date: 

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("lmerTest")){install.packages("lmerTest", dependencies = TRUE); require("lmerTest")}
if(!require("lme4")){install.packages("lme4", dependencies = TRUE); require("lme4")}
if(!require("afex")){install.packages("afex", dependencies = TRUE); require("afex")}
if(!require("effsize")){install.packages("effsize", dependencies = TRUE); require("effsize")}

# Import Data ------------------------------------------------------------------

load("deepseek_r1.RData")

# Inspect Refusals -------------------------------------------------------------

deepseek_r1 %>% group_by(condition, IAT) %>%
  summarise(noncompliances = sum(refusal))

# Compare Tokens ---------------------------------------------------------------

t.test(deepseek_r1 %>% filter(refusal) %>% pull(tokens),
       deepseek_r1 %>% filter(!refusal) %>% pull(tokens))
