
## Anonymous
# 

## Script date: 

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("ggsci")){install.packages("ggsci", dependencies = TRUE); require("ggsci")}
if(!require("effsize")){install.packages("effsize", dependencies = TRUE); require("effsize")}
if(!require("Cairo")){install.packages("Cairo", dependencies = TRUE); require("Cairo")}

# Import Data ------------------------------------------------------------------

load('../o3-mini/Visualizations/o3mini.RData')
load('../Claude3.7/Visualizations/claude.RData')
load('../DeepSeek-R1/Visualizations/deepseek_r1.RData')
load('../GPT-OSS-20B/Visualizations/gpt20b.RData')
load('../Qwen3-8B/Visualizations/qwen3.RData')

o3mini = o3mini %>% select(c('condition', 'tokens', 'IAT', 'model'))
claude = claude %>% select(c('condition', 'tokens', 'IAT', 'model'))
deepseek_r1 = deepseek_r1 %>% select(c('condition', 'tokens', 'IAT', 'model'))
gpt20b = gpt20b %>% select(c('condition', 'tokens', 'IAT', 'model'))
qwen3 = qwen3 %>% select(c('condition', 'tokens', 'IAT', 'model'))

all_IATs = rbind(o3mini, claude, deepseek_r1, gpt20b, qwen3) %>% 
  mutate(condition = case_when(
    condition == "Stereotype-Consistent" ~ "Association Compatible",
    condition == "Stereotype-Inconsistent" ~ "Association Incompatible",
    TRUE ~ condition
  ))
  
# Calculate effect sizes -------------------------------------------------------

# Function to calculate Cohen's d for each IAT and model combination
calculate_cohens_d <- function(data) {
  # Get unique IATs and models
  iats <- unique(data$IAT)
  models <- unique(data$model)
  
  # Initialize empty dataframe for results
  results <- data.frame(
    IAT = character(),
    model = character(),
    cohens_d = numeric(),
    lower_ci = numeric(),
    upper_ci = numeric(),
    stringsAsFactors = FALSE
  )
  
  # Loop through each IAT and model to calculate Cohen's d
  for (i in iats) {
    for (m in models) {
      # Filter data for this IAT and model
      subset_data <- data %>% filter(IAT == i, model == m)
      
      # Get data for each condition
      cond1_data <- subset_data %>% filter(condition == "Association Incompatible") %>% pull(tokens)
      cond2_data <- subset_data %>% filter(condition == "Association Compatible") %>% pull(tokens)
      
      # Skip if either condition has insufficient data
      if (length(cond1_data) < 2 || length(cond2_data) < 2) {
        next
      }
      
      # Handle potential typo in condition name (Incmpatible vs Incompatible)
      if (length(cond2_data) == 0) {
        cond2_data <- subset_data %>% filter(condition == "Association Incmpatible") %>% pull(tokens)
      }
      
      # Calculate Cohen's d
      d_result <- cohen.d(cond1_data, cond2_data)
      
      # Calculate 95% confidence interval (approximate method)
      # Formula: d ± 1.96 * sqrt((n1 + n2) / (n1 * n2) + d^2 / (2 * (n1 + n2)))
      n1 <- length(cond1_data)
      n2 <- length(cond2_data)
      d <- d_result$estimate
      se <- sqrt((n1 + n2) / (n1 * n2) + d^2 / (2 * (n1 + n2)))
      ci_lower <- d - 1.96 * se
      ci_upper <- d + 1.96 * se
      
      # Add to results
      results <- rbind(results, data.frame(
        IAT = i,
        model = m,
        cohens_d = d,
        lower_ci = ci_lower,
        upper_ci = ci_upper,
        stringsAsFactors = FALSE
      ))
    }
  }
  
  return(results)
}

# Calculate Cohen's d for our data
effect_sizes <- calculate_cohens_d(all_IATs)

effect_sizes = effect_sizes %>% 
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
  mutate(model = factor(model, levels = c('o3-mini', 'DeepSeek-R1', 'Claude 3.7 Sonnet', 
                                          'gpt-oss-20b', 'Qwen3-8B')))
  

ggplot(effect_sizes, aes(x = IAT, y = cohens_d, fill = model, color = model, shape = model)) +
  geom_point(size = 2, position = position_dodge(width = 0.8)) +
  geom_errorbar(aes(ymin = lower_ci, ymax = upper_ci), 
                position = position_dodge(width = 0.8), width = 0.2) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray50") +
  geom_vline(xintercept = seq(1.5, length(unique(effect_sizes$IAT))-0.5), 
             linetype = "dotted", color = "gray70") +
  scale_fill_jama() +
  scale_color_jama() +
  scale_shape_manual(values = c(21, 22, 23, 24, 25)) +
  theme_bw() +
  labs(
    y = "Cohen's d (Incompatible vs. Compatible)",
    fill = "Model",
    color = "Model",
    shape = "Model"
  ) +
  theme(
    legend.position = "top",
    axis.title.x = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.spacing = unit(0.5, "lines"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

ggsave('main.pdf', width = 11, height = 6, dpi = 'retina', device = cairo_pdf)

