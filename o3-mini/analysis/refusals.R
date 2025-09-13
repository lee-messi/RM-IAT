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

flowers_insects = read.csv('../flowers_insects.csv') %>% 
  mutate(refusal = !attribute %in% c('Pleasant', 'Unpleasant'),
         prompt = as.factor(prompt),
         condition = as.factor(condition), 
         IAT = "Flowers/Insects +\nPleasant/Unpleasant")

instruments_weapons = read.csv('../instruments_weapons.csv') %>% 
  mutate(refusal = !attribute %in% c('Pleasant', 'Unpleasant'),
         prompt = as.factor(prompt),
         condition = as.factor(condition), 
         IAT = "Instruments/Weapons +\nPleasant/Unpleasant")

race_original = read.csv('../race_original.csv') %>% 
  mutate(refusal = !attribute %in% c('Pleasant', 'Unpleasant'),
         prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/Unpleasant (1)")

race_bertrand = read.csv('../race_bertrand.csv') %>%  
  mutate(refusal = !attribute %in% c('Pleasant', 'Unpleasant'),
         prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/Unpleasant (2)")

race_nosek = read.csv('../race_nosek.csv') %>%  
  mutate(refusal = !attribute %in% c('Pleasant', 'Unpleasant'),
         prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/Unpleasant (3)")

career_family = read.csv('../career_family.csv') %>% 
  mutate(refusal = !attribute %in% c('Career', 'Family'),
         prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Men/Women +\nCareer/Family")

math_arts = read.csv('../math_arts.csv') %>% 
  mutate(refusal = !attribute %in% c('Math', 'Arts'),
         prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Men/Women +\nMathematics/Arts")

science_arts = read.csv('../science_arts.csv') %>% 
  mutate(refusal = !attribute %in% c('Science', 'Arts'),
         prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Men/Women +\nScience/Arts")

mental_physical = read.csv('../mental_physical.csv') %>% 
  mutate(refusal = !attribute %in% c('Temporary', 'Permanent'),
         prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Mental/Physical Diseases +\nTemporary/Permanent")

young_old = read.csv('../young_old.csv') %>%  
  mutate(refusal = !attribute %in% c('Pleasant', 'Unpleasant'),
         prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Young/Old People +\nPleasant/Unpleasant")

o3mini = rbind(flowers_insects, instruments_weapons, race_original, 
               race_bertrand, race_nosek, career_family, math_arts,
               science_arts, mental_physical, young_old) %>% 
  mutate(IAT = as.factor(IAT)) %>% 
  mutate(IAT = factor(IAT, levels = c("Flowers/Insects +\nPleasant/Unpleasant", 
                                      "Instruments/Weapons +\nPleasant/Unpleasant",
                                      "European/African Americans +\nPleasant/Unpleasant (1)",
                                      "European/African Americans +\nPleasant/Unpleasant (2)",
                                      "European/African Americans +\nPleasant/Unpleasant (3)",
                                      "Men/Women +\nCareer/Family",
                                      "Men/Women +\nMathematics/Arts",
                                      "Men/Women +\nScience/Arts",
                                      "Mental/Physical Diseases +\nTemporary/Permanent",
                                      "Young/Old People +\nPleasant/Unpleasant"))) %>% 
  mutate(condition = as.factor(condition))

# Compare number of refusals by RM-IAT -----------------------------------------

o3mini %>% 
  group_by(IAT) %>% 
  summarise(refusal_by_IAT = sum(refusal))

# Compare token counts between refusal and non-refusal -------------------------

t.test(o3mini %>% filter(refusal) %>% pull(tokens),
       o3mini %>% filter(!refusal) %>% pull(tokens)) # simple comparison

# Compare number of refusals by condition --------------------------------------

o3mini %>% 
  filter(refusal) %>% 
  count(condition) %>% 
  mutate(pct = n / sum(n) * 100)

