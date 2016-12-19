#https://f1000research.com/articles/4-1070

#Locating alignment files
library("airway")
dir <- system.file("extdata", 
                   package="airway", 
                   mustWork = TRUE)
list.files(dir)
#[1] "GSE52778_series_matrix.txt"        "Homo_sapiens.GRCh37.75_subset.gtf" "sample_table.csv"                  "SraRunInfo_SRP033351.csv"         
#[5] "SRR1039508_subset.bam"             "SRR1039509_subset.bam"             "SRR1039512_subset.bam"             "SRR1039513_subset.bam"            
#[9] "SRR1039516_subset.bam"             "SRR1039517_subset.bam"             "SRR1039520_subset.bam"             "SRR1039521_subset.bam"


#Table with detailed information for each of the samples linking samples to the associated FASTQ and BAM files
csvfile <- file.path(dir, "sample_table.csv")
(sampleTable <- read.csv(csvfile,row.names=1))

#SampleName    cell   dex albut        Run avgLength Experiment    Sample    BioSample
#SRR1039508 GSM1275862  N61311 untrt untrt SRR1039508       126  SRX384345 SRS508568 SAMN02422669
#SRR1039509 GSM1275863  N61311   trt untrt SRR1039509       126  SRX384346 SRS508567 SAMN02422675
#SRR1039512 GSM1275866 N052611 untrt untrt SRR1039512       126  SRX384349 SRS508571 SAMN02422678
#SRR1039513 GSM1275867 N052611   trt untrt SRR1039513        87  SRX384350 SRS508572 SAMN02422670
#SRR1039516 GSM1275870 N080611 untrt untrt SRR1039516       120  SRX384353 SRS508575 SAMN02422682
#SRR1039517 GSM1275871 N080611   trt untrt SRR1039517       126  SRX384354 SRS508576 SAMN02422673
#SRR1039520 GSM1275874 N061011 untrt untrt SRR1039520       101  SRX384357 SRS508579 SAMN02422683
#SRR1039521 GSM1275875 N061011   trt untrt SRR1039521        98  SRX384358 SRS508580 SAMN02422677

csvfile <- file.path(dir, "sample_table.csv")
(sampleTable <- read.csv(csvfile, row.names=1))

filenames <- file.path(dir, paste0(sampleTable$Run, "_subset.bam"))
file.exists(filenames)


library("Rsamtools")
bamfiles <- BamFileList(filenames, yieldSize=2000000)


seqinfo(bamfiles[1])


library("GenomicFeatures")
#library(BiocInstaller)
#biocLite("XML")




gtffile <- file.path(dir, "Homo_sapiens.GRCh37.75_subset.gtf")
(txdb <- makeTxDbFromGFF(gtffile, format="gtf", circ_seqs=character()))
