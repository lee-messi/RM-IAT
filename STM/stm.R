## Anonymous
# 
## Script date: 

# Install and/or load packages -------------------------------------------------

if(!require("tidyverse")){install.packages("tidyverse", dependencies = TRUE); require("tidyverse")}
if(!require("stm")){install.packages("stm", dependencies = TRUE); require("stm")}

# Import Data ------------------------------------------------------------------

load('../GPT-OSS-20B/viz/gpt20b.RData')
load('../Qwen3-8B/viz/qwen3.RData')
load('../Claude3.7/viz/claude.RData')
load('../DeepSeek-R1/viz/deepseek_r1.RData')

gpt20b = gpt20b %>% select(-c('prompt_id', 'text'))
qwen3 = qwen3 %>% select(-c('prompt_id', 'text'))

claude = claude %>% 
  rename(reasoning = thought) %>%
  mutate(
    condition = case_when(
      condition == "Stereotype-Consistent" ~ "Association Compatible",
      condition == "Stereotype-Inconsistent" ~ "Association Incompatible",
      TRUE ~ condition
    ),
    group = str_to_lower(group)
  ) %>%
  select(-prompt)

deepseek_r1 = deepseek_r1 %>% 
  rename(reasoning = thought) %>%
  mutate(
    condition = case_when(
      condition == "Stereotype-Consistent" ~ "Association Compatible",
      condition == "Stereotype-Inconsistent" ~ "Association Incompatible",
      TRUE ~ condition
    ),
    group = str_to_lower(group)
  ) %>%
  select(-prompt)

stm_df = rbind(claude, deepseek_r1, gpt20b, qwen3)

# Remove filler words ----------------------------------------------------------

keywords = read.csv('extracted_words.txt', header = FALSE) %>% pull(V1)
keywords = c(keywords, 'weapon', 'instrument', 'insect', 'flower')

# Remove all occurrences of keywords from reasoning column (case-insensitive), remove punctuation, and trim whitespace
stm_df <- stm_df %>%
  mutate(
    reasoning = str_remove_all(str_to_lower(reasoning), paste(str_to_lower(keywords), collapse = "|")),
    reasoning = str_remove_all(reasoning, "[[:punct:]]"),
    reasoning = str_trim(reasoning)
  )

# Preprocess the text data for STM
processed <- textProcessor(stm_df$reasoning, 
                           metadata = stm_df,
                           lowercase = TRUE,
                           removestopwords = TRUE,
                           removenumbers = TRUE,
                           removepunctuation = TRUE,
                           stem = TRUE)

# Prepare the documents
out <- prepDocuments(processed$documents, 
                     processed$vocab, 
                     processed$meta,
                     lower.thresh = 300)

# Search appropriate k value ---------------------------------------------------

search = FALSE

if(search == TRUE){
  K_range <- c(3:10)
  search_results <- searchK(documents = out$documents,
                            vocab = out$vocab,
                            K = K_range,
                            prevalence = ~ condition * model * IAT,
                            data = out$meta,
                            init.type = "Spectral",
                            seed = 1048596,
                            verbose = TRUE)
  
  # Plot the search results
  plot(search_results)
}

# Select k=4 as number of topics -----------------------------------------------

# lowest residual and increase in semantic coherence before drop
stm_model <- stm(documents = out$documents,
                 vocab = out$vocab,
                 K = 4,
                 prevalence = ~ condition * model * IAT,
                 max.em.its = 50,
                 data = out$meta,
                 init.type = "Spectral")

# View model summary
summary(stm_model)

plot(stm_model, labeltype = "frex", n = 5)
save(stm_model, file = "stm.RData")


