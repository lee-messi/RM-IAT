
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

# Mixed-Effects Models ---------------------------------------------------------

# IAT labels
iat_labels <- c("Flowers/Insects +\nPleasant/Unpleasant", 
                "Instruments/Weapons +\nPleasant/Unpleasant",
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
analyze_iat(deepseek_r1)