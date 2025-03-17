
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

race_original = read.csv('../2. race_original/race_original.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition)) %>% 
  filter(!is.na(tokens))

race_bertrand = read.csv('../3. race_bertrand/race_bertrand.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition)) %>% 
  filter(!is.na(tokens))

race_nosek = read.csv('../4. race_nosek/race_nosek.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition)) %>% 
  filter(!is.na(tokens))

# Mixed-Effects Models ---------------------------------------------------------

race_original_model <- lmer(tokens ~ condition + (1|prompt), data = race_original)
summary(race_original_model)
as.data.frame(VarCorr(race_original_model))
logLik(race_original_model)

race_bertrand_model <- lmer(tokens ~ condition + (1|prompt), data = race_bertrand)
summary(race_bertrand_model)
as.data.frame(VarCorr(race_bertrand_model))
logLik(race_bertrand_model)

race_nosek_model <- lmer(tokens ~ condition + (1|prompt), data = race_nosek)
summary(race_nosek_model)
as.data.frame(VarCorr(race_nosek_model))
logLik(race_nosek_model)

# Effect Size Calculations -----------------------------------------------------

cohen.d(race_original %>% filter(condition == 'Stereotype-Inconsistent') %>% pull(tokens), 
        race_original %>% filter(condition == 'Stereotype-Consistent') %>% pull(tokens))

cohen.d(race_bertrand %>% filter(condition == 'Stereotype-Inconsistent') %>% pull(tokens), 
        race_bertrand %>% filter(condition == 'Stereotype-Consistent') %>% pull(tokens))

cohen.d(race_nosek %>% filter(condition == 'Stereotype-Inconsistent') %>% pull(tokens), 
        race_nosek %>% filter(condition == 'Stereotype-Consistent') %>% pull(tokens))
