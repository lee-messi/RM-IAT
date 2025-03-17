
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

flowers_insects = read.csv('../0. flowers_insects/flowers_insects.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition))

instruments_weapons = read.csv('../1. instruments_weapons/instruments_weapons.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition))

race_original = read.csv('../2. race_original/race_original.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition)) %>% 
  filter(attribute %in% c('Pleasant', 'Unpleasant'))

race_bertrand = read.csv('../3. race_bertrand/race_bertrand.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition)) %>% 
  filter(attribute %in% c('Pleasant', 'Unpleasant'))

race_nosek = read.csv('../4. race_nosek/race_nosek.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition)) %>% 
  filter(attribute %in% c('Pleasant', 'Unpleasant'))

career_family = read.csv('../5. career_family/career_family.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition))

math_arts = read.csv('../6. math_arts/math_arts.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition))

science_arts = read.csv('../7. science_arts/science_arts.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition))

mental_physical = read.csv('../8. mental_physical/mental_physical.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition))

young_old = read.csv('../9. young_old/young_old.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition))

# Mixed-Effects Models ---------------------------------------------------------

flowers_insects_model <- lmer(tokens ~ condition + (1|prompt), data = flowers_insects)
summary(flowers_insects_model)
logLik(flowers_insects_model)

instruments_weapons_model <- lmer(tokens ~ condition + (1|prompt), data = instruments_weapons)
summary(instruments_weapons_model)
logLik(instruments_weapons_model)

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

career_family_model <- lmer(tokens ~ condition + (1|prompt), data = career_family)
summary(career_family_model)
logLik(career_family_model)

math_arts_model <- lmer(tokens ~ condition + (1|prompt), data = math_arts)
summary(math_arts_model)
logLik(math_arts_model)

science_arts_model <- lmer(tokens ~ condition + (1|prompt), data = science_arts)
summary(science_arts_model)
logLik(science_arts_model)

mental_physical_model <- lmer(tokens ~ condition + (1|prompt), data = mental_physical)
summary(mental_physical_model)
logLik(mental_physical_model)

young_old_model <- lmer(tokens ~ condition + (1|prompt), data = young_old)
summary(young_old_model)
logLik(young_old_model)

# Effect Size Calculations -----------------------------------------------------

cohen.d(flowers_insects %>% filter(condition == 'Stereotype-Inconsistent') %>% pull(tokens), 
        flowers_insects %>% filter(condition == 'Stereotype-Consistent') %>% pull(tokens))

cohen.d(instruments_weapons %>% filter(condition == 'Stereotype-Inconsistent') %>% pull(tokens), 
        instruments_weapons %>% filter(condition == 'Stereotype-Consistent') %>% pull(tokens))

cohen.d(race_original %>% filter(condition == 'Stereotype-Inconsistent' & attribute %in% c('Pleasant', 'Unpleasant')) %>% pull(tokens), 
        race_original %>% filter(condition == 'Stereotype-Consistent' & attribute %in% c('Pleasant', 'Unpleasant')) %>% pull(tokens))

cohen.d(race_bertrand %>% filter(condition == 'Stereotype-Inconsistent' & attribute %in% c('Pleasant', 'Unpleasant')) %>% pull(tokens), 
        race_bertrand %>% filter(condition == 'Stereotype-Consistent' & attribute %in% c('Pleasant', 'Unpleasant')) %>% pull(tokens))

cohen.d(race_nosek %>% filter(condition == 'Stereotype-Inconsistent' & attribute %in% c('Pleasant', 'Unpleasant')) %>% pull(tokens), 
        race_nosek %>% filter(condition == 'Stereotype-Consistent' & attribute %in% c('Pleasant', 'Unpleasant')) %>% pull(tokens))

cohen.d(career_family %>% filter(condition == 'Stereotype-Inconsistent') %>% pull(tokens), 
        career_family %>% filter(condition == 'Stereotype-Consistent') %>% pull(tokens))

cohen.d(math_arts %>% filter(condition == 'Stereotype-Inconsistent') %>% pull(tokens), 
        math_arts %>% filter(condition == 'Stereotype-Consistent') %>% pull(tokens))

cohen.d(science_arts %>% filter(condition == 'Stereotype-Inconsistent') %>% pull(tokens), 
        science_arts %>% filter(condition == 'Stereotype-Consistent') %>% pull(tokens))

cohen.d(mental_physical %>% filter(condition == 'Stereotype-Inconsistent') %>% pull(tokens), 
        mental_physical %>% filter(condition == 'Stereotype-Consistent') %>% pull(tokens))

cohen.d(young_old %>% filter(condition == 'Stereotype-Inconsistent') %>% pull(tokens), 
        young_old %>% filter(condition == 'Stereotype-Consistent') %>% pull(tokens))

