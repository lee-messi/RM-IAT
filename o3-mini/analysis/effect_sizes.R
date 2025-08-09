
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

load("o3_mini.RData")

# Descriptive Statistics -------------------------------------------------------

o3_mini %>% 
  filter(!refusal) %>%
  group_by(IAT, condition) %>% 
  summarise(
    mean_token = round(mean(tokens, na.rm = TRUE), 2),
    sd_token = round(sd(tokens, na.rm = TRUE), 2)
  )

# Effect sizes -----------------------------------------------------------------

cohen.d(o3_mini %>% 
          filter(IAT == "Flowers/Insects +\nPleasant/Unpleasant" & 
                   condition == 'Association-Incompatible') %>% pull(tokens),
        o3_mini %>% 
          filter(IAT == "Flowers/Insects +\nPleasant/Unpleasant" &
                   condition == 'Association-Compatible') %>% pull(tokens))

cohen.d(o3_mini %>% 
          filter(IAT == "Instruments/Weapons +\nPleasant/Unpleasant" & 
                   condition == 'Association-Incompatible') %>% pull(tokens),
        o3_mini %>% 
          filter(IAT == "Instruments/Weapons +\nPleasant/Unpleasant" &
                   condition == 'Association-Compatible') %>% pull(tokens))

cohen.d(o3_mini %>% 
          filter(IAT == "European/African Americans +\nPleasant/Unpleasant (1)" & 
                   condition == 'Association-Incompatible') %>% pull(tokens),
        o3_mini %>% 
          filter(IAT == "European/African Americans +\nPleasant/Unpleasant (1)" &
                   condition == 'Association-Compatible') %>% pull(tokens))

cohen.d(o3_mini %>% 
          filter(IAT == "European/African Americans +\nPleasant/Unpleasant (2)" & 
                   condition == 'Association-Incompatible') %>% pull(tokens),
        o3_mini %>% 
          filter(IAT == "European/African Americans +\nPleasant/Unpleasant (2)" &
                   condition == 'Association-Compatible') %>% pull(tokens))

cohen.d(o3_mini %>% 
          filter(IAT == "European/African Americans +\nPleasant/Unpleasant (3)" & 
                   condition == 'Association-Incompatible') %>% pull(tokens),
        o3_mini %>% 
          filter(IAT == "European/African Americans +\nPleasant/Unpleasant (3)" &
                   condition == 'Association-Compatible') %>% pull(tokens))

cohen.d(o3_mini %>% 
          filter(IAT == "Men/Women +\nCareer/Family" & 
                   condition == 'Association-Incompatible') %>% pull(tokens),
        o3_mini %>% 
          filter(IAT == "Men/Women +\nCareer/Family" &
                   condition == 'Association-Compatible') %>% pull(tokens))

cohen.d(o3_mini %>% 
          filter(IAT == "Men/Women +\nMathematics/Arts" & 
                   condition == 'Association-Incompatible') %>% pull(tokens),
        o3_mini %>% 
          filter(IAT == "Men/Women +\nMathematics/Arts" &
                   condition == 'Association-Compatible') %>% pull(tokens))

cohen.d(o3_mini %>% 
          filter(IAT == "Men/Women +\nScience/Arts" & 
                   condition == 'Association-Incompatible') %>% pull(tokens),
        o3_mini %>% 
          filter(IAT == "Men/Women +\nScience/Arts" &
                   condition == 'Association-Compatible') %>% pull(tokens))

cohen.d(o3_mini %>% 
          filter(IAT == "Mental/Physical Diseases +\nTemporary/Permanent" & 
                   condition == 'Association-Incompatible') %>% pull(tokens),
        o3_mini %>% 
          filter(IAT == "Mental/Physical Diseases +\nTemporary/Permanent" &
                   condition == 'Association-Compatible') %>% pull(tokens))

cohen.d(o3_mini %>% 
          filter(IAT == "Young/Old People +\nPleasant/Unpleasant" & 
                   condition == 'Association-Incompatible') %>% pull(tokens),
        o3_mini %>% 
          filter(IAT == "Young/Old People +\nPleasant/Unpleasant" &
                   condition == 'Association-Compatible') %>% pull(tokens))

