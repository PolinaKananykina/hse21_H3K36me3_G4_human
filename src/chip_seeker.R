###

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene", force = TRUE)
BiocManager::install("ChIPseeker")
BiocManager::install("clusterProfiler")


library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(clusterProfiler)
library(org.Hs.eg.db)

###
OUT_DIR <- ''
NAME <- 'H3K36me3_MCF-7.ENCFF783EAZ.hg19.filtered'
#NAME <- 'H3K36me3_MCF-7.ENCFF994KPZ.hg19.filtered'
BED_FN <- paste0('', NAME, '.bed')

###

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

peakAnno <- annotatePeak(BED_FN, tssRegion=c(-3000, 3000), TxDb=txdb, annoDb="org.Hs.eg.db")

#pdf(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.pdf'))
png(paste0(OUT_DIR, 'chip_seeker.', NAME, '.plotAnnoPie.png'))
plotAnnoPie(peakAnno)
dev.off()
