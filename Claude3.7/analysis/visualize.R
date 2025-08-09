
## Anonymous
# 

## Script date: 

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("ggsci")){install.packages("ggsci", dependencies = TRUE); require("ggsci")}
if(!require("ggsignif")){install.packages("ggsignif", dependencies = TRUE); require("ggsignif")}
if(!require("Cairo")){install.packages("Cairo", dependencies = TRUE); require("Cairo")}

# Import Data ------------------------------------------------------------------

flowers_insects = read.csv('../flowers_insects.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition), 
         IAT = "Flowers/Insects +\nPleasant/Unpleasant",
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'))

instruments_weapons = read.csv('../instruments_weapons.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition), 
         IAT = "Instruments/Weapons +\nPleasant/Unpleasant",
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'))

race_original = read.csv('../race_original.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/Unpleasant (1)",
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'))

race_bertrand = read.csv('../race_bertrand.csv') %>%  
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/Unpleasant (2)",
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'))

race_nosek = read.csv('../race_nosek.csv') %>%  
  filter(attribute %in% c('Pleasant', 'Unpleasant')) %>%
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "European/African Americans +\nPleasant/Unpleasant (3)",
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'))

career_family = read.csv('../career_family.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Men/Women +\nCareer/Family",
         refusal = !attribute %in% c('Career', 'Family'))

math_arts = read.csv('../math_arts.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Men/Women +\nMathematics/Arts",
         refusal = !attribute %in% c('Math', 'Arts'))

science_arts = read.csv('../science_arts.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Men/Women +\nScience/Arts",
         refusal = !attribute %in% c('Science', 'Arts'))

mental_physical = read.csv('../mental_physical.csv') %>% 
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Mental/Physical Diseases +\nTemporary/Permanent",
         refusal = !attribute %in% c('Temporary', 'Permanent'))

young_old = read.csv('../young_old.csv') %>%  
  mutate(prompt = as.factor(prompt),
         condition = as.factor(condition),
         IAT = "Young/Old People +\nPleasant/Unpleasant",
         refusal = !attribute %in% c('Pleasant', 'Unpleasant'))

claude = rbind(flowers_insects, instruments_weapons, race_original, 
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
  )) %>% 
  mutate(model = 'Claude 3.7 Sonnet')

save(claude, file = 'claude.RData')

claude = claude %>% 
  filter(!refusal) %>%
  group_by(IAT) %>% 
  mutate(tokens = scale(tokens)) %>%
  ungroup()

# Bar Plots --------------------------------------------------------------------

# Create the plot
ggplot(claude, aes(x = condition, y = tokens, fill = condition)) +
  geom_bar(stat = "summary", fun = "mean", position = "dodge") +
  geom_errorbar(stat = "summary", fun.data = "mean_se", 
                position = position_dodge(width = 0.9), width = 0.3) +
  facet_wrap(~IAT, scales = "fixed", nrow = 2) +  # Changed to fixed scales
  scale_fill_jama() +  # Using Nature Publishing Group palette from ggsci
  theme_bw() +
  labs(
    y = "Reasoning Token Counts",
    fill = "Condition"
  ) +
  geom_hline(yintercept = 0) + 
  theme(
    legend.position = "bottom",
    legend.title = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    panel.grid.minor = element_blank(),
    panel.spacing = unit(0.5, "lines"))

ggsave('claude.pdf', width = 10, height = 6, dpi = 'retina', device = cairo_pdf)

