# Section I - Script Information ----
# Author: Emmarie Alexander
# Email: emmarie.alexander@tamu.edu
# Date Written: 20-February-2025
# Last modified: 29-Jul-2025
# Version: 2.0
# Purpose: plot the alignment lengths

# Section II - Library Installation and Loading ----
# Install any necessary packages
if (!requireNamespace("ggplot2", quietly = TRUE))
  install.packages("ggplot2")
if (!requireNamespace("tidyr", quietly = TRUE))
  install.packages("tidyr")
if (!requireNamespace("scales", quietly = TRUE))
  install.packages("scales")
if (!requireNamespace("extrafont", quietly = TRUE))
  install.packages("extrafont")
if (!requireNamespace("patchwork", quietly = TRUE))
  install.packages("patchwork")

# Load any necessary packages
library(ggplot2)
library(tidyr)
library(scales)
library(extrafont)
library(patchwork)

# To ensure that the Arial font is available, run this once:
extrafont::font_import(pattern = "Arial", prompt = FALSE)
extrafont::loadfonts()

# Section III - Bull-referenced alignment ----
# Build the data frame
bull_alns <- data.frame(
  Category = c(
    "Loci",
    "Genes",
    "Coding",
    "Exonic",
    "Noncoding",
    "Intronic",
    "Neutral"
  ),
  Total = c(81461, 78846, 16062, 25269, 65399, 53577, 15910),
  Parsimony = c(64141, 61811, 6965, 14295, 57176, 47516, 15569)
)

# Transform dataframe into long format
bull_long_alns <- pivot_longer(
  bull_alns,
  cols = c(Total, Parsimony),
  names_to = "SiteType",
  values_to = "Values"
)

bull_long_alns$Category <- factor(bull_long_alns$Category, levels = c(
  "Loci",
  "Genes",
  "Coding",
  "Exonic",
  "Noncoding",
  "Intronic",
  "Neutral"
))

# Visualize data using a grouped bar chart
bull_bar <- ggplot(bull_long_alns, aes(
  x = Category,
  y = Values,
  fill = reorder(SiteType, -Values)
)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.9)) +
  scale_fill_manual(values = c("Total" = "#229954", "Parsimony" = "#CCEBC5"),
                    labels = c("Total" = "Total", "Parsimony" = "Parsimony-Informative")) +
  scale_y_continuous(
    labels = function(x)
      paste(x / 1000, "Kb")
  ) +
  labs(title = "Bull-referenced alignment",
       x = "Sequence Type",
       y = "Value (Kb)",
       fill = "Sites") +
  theme_minimal() +
  # Requires Arial to be registered
  theme(
    text = element_text(family = "Arial"),
    axis.text.x = element_text(
      angle = 45,
      hjust = 1,
      size = 12
    ),
    plot.title = element_text(
      size = 16,
      face = "bold",
      color = "black",
      hjust = 0.5
    ),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
  )

bull_bar

# Section IV - Human-referenced alignment ----
# Build the data frame
human_alns <- data.frame(
  Category = c(
    "Loci",
    "Genes",
    "Coding",
    "Exonic",
    "Noncoding",
    "Intronic",
    "Neutral"
  ),
  Total = c(82318, 80953, 15887, 30348, 66431, 50605, 16182),
  Parsimony = c(65041, 63811, 6897, 18849, 58144, 44962, 15869)
)

# Transform dataframe into long format
human_long_alns <- pivot_longer(
  human_alns,
  cols = c(Total, Parsimony),
  names_to = "SiteType",
  values_to = "Values"
)

human_long_alns$Category <- factor(human_long_alns$Category, levels = c(
  "Loci",
  "Genes",
  "Coding",
  "Exonic",
  "Noncoding",
  "Intronic",
  "Neutral"
))

# Visualize data using a grouped bar chart
human_bar <- ggplot(human_long_alns, aes(
  x = Category,
  y = Values,
  fill = reorder(SiteType, -Values)
)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.9)) +
  scale_fill_manual(values = c("Total" = "#2471a3", "Parsimony" = "#B3CDE3"),
                    labels = c("Total" = "Total", "Parsimony" = "Parsimony-Informative")) +
  scale_y_continuous(
    labels = function(x)
      paste(x / 1000, "Kb")
  ) +
  labs(title = "Human-referenced alignment",
       x = "Sequence Type",
       y = "Value (Kb)",
       fill = "Sites") +
  theme_minimal() +
  theme(
    text = element_text(family = "Arial"),
    # Requires Arial to be registered
    axis.text.x = element_text(
      angle = 45,
      hjust = 1,
      size = 12
    ),
    plot.title = element_text(
      size = 16,
      face = "bold",
      color = "black",
      hjust = 0.5
    ),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
)

# Section V - Combine the plots and save the final figure ----
# Use the patchwork package to vertically stack the plots
alignment_stats <- human_bar / bull_bar

# Save plot using ggsave
ggsave(
  "alignment_statistics_withParsimonyInformativeSites_12June2025.png",
  width = 8,
  height = 6,
  dpi = 600,
  plot = alignment_stats
)
