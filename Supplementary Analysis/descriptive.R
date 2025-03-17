
## Anonymous
# 

## Script date: 

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("ggsci")){install.packages("ggsci", dependencies = TRUE); require("ggsci")}
if(!require("ggsignif")){install.packages("ggsignif", dependencies = TRUE); require("ggsignif")}
if(!require("Cairo")){install.packages("Cairo", dependencies = TRUE); require("Cairo")}

# Import Data ------------------------------------------------------------------

flowers_insects = read.csv('../0. flowers_insects/flowers_insects.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition), 
         IAT = "Flowers and\nInsects")

instruments_weapons = read.csv('../1. instruments_weapons/instruments_weapons.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition), 
         IAT = "Instruments and\nWeapons")

race_original = read.csv('../2. race_original/race_original.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Race IAT (1)") %>% 
  filter(attribute %in% c('Pleasant', 'Unpleasant'))

race_bertrand = read.csv('../3. race_bertrand/race_bertrand.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Race IAT (2)") %>% 
  filter(attribute %in% c('Pleasant', 'Unpleasant'))

race_nosek = read.csv('../4. race_nosek/race_nosek.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Race IAT (3)") %>% 
  filter(attribute %in% c('Pleasant', 'Unpleasant'))

career_family = read.csv('../5. career_family/career_family.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Career and Family")

math_arts = read.csv('../6. math_arts/math_arts.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Math and Arts")

science_arts = read.csv('../7. science_arts/science_arts.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Science and Arts")

mental_physical = read.csv('../8. mental_physical/mental_physical.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Mental and\nPhysical Diseases")

young_old = read.csv('../9. young_old/young_old.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Young and Old")

all_IATs = rbind(flowers_insects, instruments_weapons, race_original, 
                 race_bertrand, race_nosek, career_family, math_arts,
                 science_arts, mental_physical, young_old) %>% 
  mutate(IAT = as.factor(IAT)) %>% 
  mutate(IAT = factor(IAT, levels = c("Flowers and\nInsects", "Instruments and\nWeapons", 
                                      "Race IAT (1)", "Race IAT (2)", "Race IAT (3)",
                                      "Career and Family", "Math and Arts",
                                      "Science and Arts", "Mental and\nPhysical Diseases",
                                      "Young and Old")))

# Descriptive Statistics -------------------------------------------------------

descriptive_table = all_IATs %>% 
  group_by(IAT, condition) %>% 
  summarise(
    mean_token = mean(tokens, na.rm = TRUE),
    sd_token = sd(tokens, na.rm = TRUE)
  )

