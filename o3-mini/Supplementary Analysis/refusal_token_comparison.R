
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
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'), 
         condition = as.factor(condition), 
         IAT = "Flowers/Insects +\nPleasant/Unpleasant")

instruments_weapons = read.csv('../1. instruments_weapons/instruments_weapons.csv') %>% 
  mutate(prompt = as.factor(prompt),
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'), 
         condition = as.factor(condition), 
         IAT = "Instruments/Weapons +\nPleasant/Unpleasant")

race_original = read.csv('../2. race_original/race_original.csv') %>% 
  mutate(prompt = as.factor(prompt),
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'), 
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/Unpleasant (1)")

race_bertrand = read.csv('../3. race_bertrand/race_bertrand.csv') %>%  
  mutate(prompt = as.factor(prompt),
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'), 
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/Unpleasant (2)")

race_nosek = read.csv('../4. race_nosek/race_nosek.csv') %>%
  mutate(prompt = as.factor(prompt),
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'), 
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/Unpleasant (3)")

career_family = read.csv('../5. career_family/career_family.csv') %>% 
  mutate(prompt = as.factor(prompt),
         refusal = !attribute %in% c('Career', 'Family'),
         condition = as.factor(condition),
         IAT = "Men/Women +\nCareer/Family")

math_arts = read.csv('../6. math_arts/math_arts.csv') %>% 
  mutate(prompt = as.factor(prompt),
         refusal = !attribute %in% c('Math', 'Arts'),
         condition = as.factor(condition),
         IAT = "Men/Women +\nMathematics/Arts")

science_arts = read.csv('../7. science_arts/science_arts.csv') %>% 
  mutate(prompt = as.factor(prompt),
         refusal = !attribute %in% c('Science', 'Arts'),
         condition = as.factor(condition),
         IAT = "Men/Women +\nScience/Arts")

mental_physical = read.csv('../8. mental_physical/mental_physical.csv') %>%
  mutate(prompt = as.factor(prompt),
         refusal = !attribute %in% c('Temporary', 'Permanent'),
         condition = as.factor(condition),
         IAT = "Mental/Physical Diseases +\nTemporary/Permanent")

young_old = read.csv('../9. young_old/young_old.csv') %>%  
  mutate(prompt = as.factor(prompt),
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'),
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
  mutate(condition = case_when(
    condition == "Stereotype-Consistent" ~ "Association-Compatible",
    condition == "Stereotype-Inconsistent" ~ "Association-Incompatible",
    TRUE ~ condition
  ))

# Compare Tokens ---------------------------------------------------------------

t.test(o3mini %>% filter(refusal) %>% pull(tokens),
       o3mini %>% filter(!refusal) %>% pull(tokens))

