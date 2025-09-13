## Anonymous
# 
## Script date: 
# Install and/or load packages -------------------------------------------------
if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("lmerTest")){install.packages("lmerTest", dependencies = TRUE); require("lmerTest")}
if(!require("lme4")){install.packages("lme4", dependencies = TRUE); require("lme4")}
if(!require("afex")){install.packages("afex", dependencies = TRUE); require("afex")}
if(!require("effsize")){install.packages("effsize", dependencies = TRUE); require("effsize")}

# Function to calculate refusals -----------------------------------------------

calculate_refusals <- function(df_name, filter_attributes) {
  df_full <- get(df_name)
  df_filtered <- df_full %>% filter(attribute %in% filter_attributes)
  refusals <- nrow(df_full) - nrow(df_filtered)
  return(data.frame(
    dataset = df_name,
    total_rows = nrow(df_full),
    filtered_rows = nrow(df_filtered),
    refusals = refusals,
    refusal_rate = round(refusals / nrow(df_full) * 100, 2)
  ))
}

# Import Data ------------------------------------------------------------------

flowers_insects_raw = read.csv('../flowers_insects.csv')
flowers_insects = flowers_insects_raw %>% 
  filter(attribute %in% c('Pleasant', 'Unpleasant')) %>%
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition), 
         IAT = "Flowers/Insects +\nPleasant/UnPleasant")

instruments_weapons_raw = read.csv('../instruments_weapons.csv')
instruments_weapons = instruments_weapons_raw %>% 
  filter(attribute %in% c('Pleasant', 'Unpleasant')) %>%
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition), 
         IAT = "Instruments/Weapons +\nPleasant/UnPleasant")

race_original_raw = read.csv('../race_original.csv')
race_original = race_original_raw %>% 
  filter(attribute %in% c('Pleasant', 'Unpleasant')) %>%
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/UnPleasant (1)")

race_bertrand_raw = read.csv('../race_bertrand.csv')
race_bertrand = race_bertrand_raw %>%  
  filter(attribute %in% c('Pleasant', 'Unpleasant')) %>%
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/UnPleasant (2)")

race_nosek_raw = read.csv('../race_nosek.csv')
race_nosek = race_nosek_raw %>%  
  filter(attribute %in% c('Pleasant', 'Unpleasant')) %>%
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/UnPleasant (3)")

career_family_raw = read.csv('../career_family.csv')
career_family = career_family_raw %>% 
  filter(attribute %in% c('Career', 'Family')) %>%
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Men/Women +\nCareer/Family")

math_arts_raw = read.csv('../math_arts.csv')
math_arts = math_arts_raw %>% 
  filter(attribute %in% c('Math', 'Arts')) %>%
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Men/Women +\nMathematics/Arts")

science_arts_raw = read.csv('../science_arts.csv')
science_arts = science_arts_raw %>% 
  filter(attribute %in% c('Science', 'Arts')) %>%
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Men/Women +\nScience/Arts")

mental_physical_raw = read.csv('../mental_physical.csv')
mental_physical = mental_physical_raw %>% 
  filter(attribute %in% c('Temporary', 'Permanent')) %>%
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Mental/Physical Diseases +\nTemporary/Permanent")

young_old_raw = read.csv('../young_old.csv')
young_old = young_old_raw %>%  
  filter(attribute %in% c('Pleasant', 'Unpleasant')) %>%
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Young/Old People +\nPleasant/UnPleasant")

# Calculate refusals for each dataset ------------------------------------------
refusal_summary <- rbind(
  calculate_refusals("flowers_insects_raw", c('Pleasant', 'Unpleasant')),
  calculate_refusals("instruments_weapons_raw", c('Pleasant', 'Unpleasant')),
  calculate_refusals("race_original_raw", c('Pleasant', 'Unpleasant')),
  calculate_refusals("race_bertrand_raw", c('Pleasant', 'Unpleasant')),
  calculate_refusals("race_nosek_raw", c('Pleasant', 'Unpleasant')),
  calculate_refusals("career_family_raw", c('Career', 'Family')),
  calculate_refusals("math_arts_raw", c('Math', 'Arts')),
  calculate_refusals("science_arts_raw", c('Science', 'Arts')),
  calculate_refusals("mental_physical_raw", c('Temporary', 'Permanent')),
  calculate_refusals("young_old_raw", c('Pleasant', 'Unpleasant'))
)

# Display refusal summary
print("Refusal Summary:")
print(refusal_summary)

# Create a more readable summary with IAT names
refusal_summary_readable <- refusal_summary %>%
  mutate(IAT_Name = case_when(
    dataset == "flowers_insects_raw" ~ "Flowers/Insects + Pleasant/UnPleasant",
    dataset == "instruments_weapons_raw" ~ "Instruments/Weapons + Pleasant/UnPleasant", 
    dataset == "race_original_raw" ~ "European/African Americans + Pleasant/UnPleasant (1)",
    dataset == "race_bertrand_raw" ~ "European/African Americans + Pleasant/UnPleasant (2)",
    dataset == "race_nosek_raw" ~ "European/African Americans + Pleasant/UnPleasant (3)",
    dataset == "career_family_raw" ~ "Men/Women + Career/Family",
    dataset == "math_arts_raw" ~ "Men/Women + Mathematics/Arts",
    dataset == "science_arts_raw" ~ "Men/Women + Science/Arts", 
    dataset == "mental_physical_raw" ~ "Mental/Physical Diseases + Temporary/Permanent",
    dataset == "young_old_raw" ~ "Young/Old People + Pleasant/UnPleasant"
  )) %>%
  select(IAT_Name, total_rows, filtered_rows, refusals, refusal_rate)

print("\nReadable Refusal Summary:")
print(refusal_summary_readable)

