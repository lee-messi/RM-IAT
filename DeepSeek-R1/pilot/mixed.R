
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

instruments_weapons = read.csv('instruments_weapons.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition), 
         IAT = "Instruments/Weapons +\nPleasant/Unpleasant",
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'))

race_original = read.csv('race_original.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/Unpleasant (1)",
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'))

race_bertrand = read.csv('race_bertrand.csv') %>%  
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/Unpleasant (2)",
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'))

race_nosek = read.csv('race_nosek.csv') %>%  
  filter(attribute %in% c('Pleasant', 'Unpleasant')) %>%
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/Unpleasant (3)",
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'))

career_family = read.csv('career_family.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Men/Women +\nCareer/Family",
         refusal = !attribute %in% c('Career', 'Family'))

math_arts = read.csv('math_arts.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Men/Women +\nMathematics/Arts",
         refusal = !attribute %in% c('Math', 'Arts'))

science_arts = read.csv('science_arts.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Men/Women +\nScience/Arts",
         refusal = !attribute %in% c('Science', 'Arts'))

mental_physical = read.csv('mental_physical.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Mental/Physical Diseases +\nTemporary/Permanent",
         refusal = !attribute %in% c('Temporary', 'Permanent'))

young_old = read.csv('young_old.csv') %>%  
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Young/Old People +\nPleasant/Unpleasant",
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'))

deepseek_r1_pilot = rbind(instruments_weapons, race_original, 
                    race_bertrand, race_nosek, career_family, math_arts,
                    science_arts, mental_physical, young_old) %>% 
  mutate(IAT = as.factor(IAT)) %>% 
  mutate(IAT = factor(IAT, levels = c("Instruments/Weapons +\nPleasant/Unpleasant",
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
  )) %>% 
  mutate(model = 'DeepSeek-R1')

# Mixed-Effects Models ---------------------------------------------------------

# IAT labels
iat_labels <- c("Instruments/Weapons +\nPleasant/Unpleasant",
                "European/African Americans +\nPleasant/Unpleasant (1)",
                "European/African Americans +\nPleasant/Unpleasant (2)",
                "European/African Americans +\nPleasant/Unpleasant (3)",
                "Men/Women +\nCareer/Family",
                "Men/Women +\nMathematics/Arts",
                "Men/Women +\nScience/Arts",
                "Mental/Physical Diseases +\nTemporary/Permanent",
                "Young/Old People +\nPleasant/Unpleasant")

# Function to analyze IAT data
analyze_iat <- function(df) {
  # Analyze each IAT type
  for(i in 1:length(iat_labels)) {
    cat("\n", rep("-", 50), "\n")
    cat("IAT:", iat_labels[i], "\n")
    cat(rep("-", 50), "\n")
    
    # Filter data for current IAT
    current_data <- df %>% filter(IAT == iat_labels[i])
    
    model <- lmer(tokens ~ condition + (1|prompt), data = current_data)
    
    print(summary(model))
    cat("\nVariance Components:\n")
    print(as.data.frame(VarCorr(model)))
    cat("\nLog-Likelihood:", logLik(model), "\n")
  }
}

# Run analysis
analyze_iat(deepseek_r1_pilot)