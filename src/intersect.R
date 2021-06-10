BiocManager::install("ChIPpeakAnno")
BiocManager::install("org.Hs.eg.db")
BiocManager::install("org.Mm.eg.db")

library(ChIPpeakAnno)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)
library(ggplot2)
library(dplyr)
library(tidyr)   # replace_na
library(tibble)

OUT_DIR <- ''

###


peaks <- toGRanges(paste0(OUT_DIR, 'H3K36me3_MCF-7.intersect_with_G4_seq_Li_K.bed'), format="BED")
peaks[1:2]

annoData <- toGRanges(TxDb.Hsapiens.UCSC.hg19.knownGene)
annoData[1:2]


anno <- annotatePeakInBatch(peaks, AnnotationData=annoData, 
                            output="overlapping", 
                            FeatureLocForDistance="TSS",
                            bindingRegion=c(-2000, 300))
data.frame(anno) %>% head()

anno$symbol <- xget(anno$feature, org.Hs.egSYMBOL)
data.frame(anno) %>% head()

anno_df <- data.frame(anno)
write.table(anno_df, file=paste0(OUT_DIR, 'H3K36me3_MCF-7.intersect_with_G4_seq_Li_K.genes.txt'),
            col.names = TRUE, row.names = FALSE, sep = '\t', quote = FALSE)

uniq_genes_df <- unique(anno_df['symbol'])
write.table(uniq_genes_df, file=paste0(OUT_DIR, 'H3K36me3_MCF-7.intersect_with_G4_seq_Li_K.genes_uniq.txt'),
            col.names = FALSE, row.names = FALSE, sep = '\t', quote = FALSE)