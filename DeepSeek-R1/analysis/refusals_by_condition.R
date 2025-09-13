
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

read.csv('../0. flowers_insects/flowers_insects.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition), 
         IAT = "Flowers and\nInsects") %>% 
  filter(!attribute %in% c('Pleasant', 'Unpleasant')) %>%
  nrow() %>% print()

read.csv('../1. instruments_weapons/instruments_weapons.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition), 
         IAT = "Instruments and\nWeapons") %>% 
  filter(!attribute %in% c('Pleasant', 'Unpleasant')) %>%
  nrow() %>% print()

read.csv('../2. race_original/race_original.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Race IAT (1)") %>% 
  filter(!attribute %in% c('Pleasant', 'Unpleasant')) %>%
  nrow() %>% print()

read.csv('../3. race_bertrand/race_bertrand.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Race IAT (2)") %>% 
  filter(!attribute %in% c('Pleasant', 'Unpleasant')) %>%
  nrow() %>% print()

read.csv('../4. race_nosek/race_nosek.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Race IAT (3)") %>% 
  filter(!attribute %in% c('Pleasant', 'Unpleasant')) %>%
  nrow() %>% print()

read.csv('../5. career_family/career_family.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Career and Family") %>% 
  filter(!attribute %in% c('Career', 'Family')) %>%
  nrow() %>% print()

read.csv('../6. math_arts/math_arts.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Math and Arts") %>% 
  filter(!attribute %in% c('Math', 'Arts')) %>%
  nrow() %>% print()

read.csv('../7. science_arts/science_arts.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Science and Arts") %>% 
  filter(!attribute %in% c('Science', 'Arts')) %>%
  nrow() %>% print()

read.csv('../8. mental_physical/mental_physical.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Mental and\nPhysical Diseases") %>% 
  filter(!attribute %in% c('Temporary', 'Permanent')) %>%
  nrow() %>% print()

read.csv('../9. young_old/young_old.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Young and Old") %>% 
  filter(!attribute %in% c('Pleasant', 'Unpleasant')) %>%
  nrow() %>% print()

# Inspect Noncompliances -------------------------------------------------------

race_original_filtered = read.csv('../2. race_original/race_original.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Race IAT (1)") %>% 
  filter(!attribute %in% c('Pleasant', 'Unpleasant'))

race_bertrand_filtered = read.csv('../3. race_bertrand/race_bertrand.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Race IAT (2)") %>% 
  filter(!attribute %in% c('Pleasant', 'Unpleasant'))

race_nosek_filtered = read.csv('../4. race_nosek/race_nosek.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Race IAT (3)") %>% 
  filter(!attribute %in% c('Pleasant', 'Unpleasant'))

all_race_IATs = rbind(race_original_filtered, 
                      race_bertrand_filtered,
                      race_nosek_filtered)

table(all_race_IATs$condition)
