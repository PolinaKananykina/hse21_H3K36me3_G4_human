library(ggplot2)
library(dplyr)
# library(tidyr)   # replace_na
# library(tibble)  # column_to_rownames

# NAME <- 'H3K36me3_MCF-7.ENCFF783EAZ.hg19'
NAME <- 'H3K36me3_MCF-7.ENCFF994KPZ.hg19'

OUT_DIR <- 'Results/'

bed_df <- read.delim(paste0('/', NAME, '.bed'), as.is = TRUE, header = FALSE)
colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
bed_df$len <- bed_df$end - bed_df$start
head(bed_df)

bed_df <- bed_df %>%
  arrange(-len) %>%
  filter(len < 2750)


ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('filter_peaks.', NAME, '.filtered.hist.pdf'), path = OUT_DIR)

