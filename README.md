# Implicit Bias-Like Patterns in Reasoning Models

Paper and related materials for [Lee](https://lee-messi.github.io/) and [Lai](http://calvinklai.com/) (2025). The abstract for the paper is as follows:

> Implicit bias refers to automatic mental processes that shape perceptions, judgments, and behaviors. Previous research on ``implicit bias" in LLMs focused primarily on outputs rather than processing. We present the Reasoning Model Implicit Association Test (RM-IAT) to study implicit bias-like patterns in reasoning models–LLMs using step-by-step reasoning for complex tasks. Using RM-IAT, we find o3-mini and DeepSeek R1 require more tokens when processing association-incompatible information, mirroring human implicit bias patterns. Conversely, Claude 3.7 Sonnet displays reversed patterns for race and gender tests, requiring more tokens for association-compatible information. This reversal appears linked to differences in safety mechanism activation, increasing deliberation in sensitive contexts. These findings suggest AI systems can exhibit processing patterns analogous to both human implicit bias and bias correction mechanisms.

Please feel free to send me an [email](mailto:hojunlee@wustl.edu), or open an "Issue" [here](https://github.com/lee-messi/RM-IAT/issues). 

## Data Availability Statement

All data and code necessary to reproduce the results presented in this paper are publicly available in this repository. This includes the data collection code, raw data, and analysis scripts used in our study. No additional data or resources beyond those contained in this repository are required to replicate our findings.

## Naming Inconsistencies

You may notice that in the naming of conditions used for data collection (i.e., "Stereotype-Consistent" and "Stereotype-Inconsistent") is inconsistent with that found in the Pre-print (i.e., "Association-Compatible" and "Association-Incompatible"). The naming of the conditions were modified during writing so that it captures those that are not about stereotypes. The Young/Old People + Pleasant/Unpleasant RM-IAT, for example, was about attitudes. 

