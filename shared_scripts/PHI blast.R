```{r}
write_fasta_clusters <- function(df, cluster_number, file_path) {
  num_sequences <- nrow(df)
  sequences_per_file <- 400
  
  # Calculate the number of files needed
  num_files <- ceiling(num_sequences / sequences_per_file)
  
  # Create the output directory if it doesn't exist
  dir.create(dirname(file_path), recursive = TRUE, showWarnings = FALSE)
  
  # Split the dataframe into chunks of size sequences_per_file
  sequence_chunks <- split(df, ceiling(seq_along(df$protein_id) / sequences_per_file))
  
  # Define a function to write a sequence chunk to a file with cluster labels
  write_chunk <- function(chunk, cluster_num, chunk_num) {
    cluster_label <- paste0("cluster_", cluster_num, ".", chunk_num)
    chunk_file_path <- file.path(dirname(file_path), paste0(cluster_label, ".fasta"))
    fasta_string <- paste0(">", chunk$protein_id, "\n", chunk$Sequence, "\n")
    writeLines(fasta_string, con = chunk_file_path)
  }
  
  # Use mapply to write each sequence chunk to a separate file with cluster labels
  mapply(write_chunk, sequence_chunks, cluster_number, seq_along(sequence_chunks))
}
```

```{r}

cluster_1_genes.id <- gtf.faa.omicsbox[gtf.faa.omicsbox$gene_id %in% cluster_1_genes, ]
write_fasta_clusters(cluster_1_genes.id, 1, "/mnt/data/barry/projects/Schroeter_Pcinnamomi/Timecourse analysis/TCAseq_Fasta/cluster_output.fasta")
cluster_2_genes.id <- gtf.faa.omicsbox[gtf.faa.omicsbox$gene_id %in% cluster_2_genes, ]
write_fasta_clusters(cluster_2_genes.id, 2, "/mnt/data/barry/projects/Schroeter_Pcinnamomi/Timecourse analysis/TCAseq_Fasta/cluster_output.fasta")
cluster_3_genes.id <- gtf.faa.omicsbox[gtf.faa.omicsbox$gene_id %in% cluster_3_genes, ]
write_fasta_clusters(cluster_3_genes.id, 3, "/mnt/data/barry/projects/Schroeter_Pcinnamomi/Timecourse analysis/TCAseq_Fasta/cluster_output.fasta")
cluster_4_genes.id <- gtf.faa.omicsbox[gtf.faa.omicsbox$gene_id %in% cluster_4_genes, ]
write_fasta_clusters(cluster_4_genes.id, 4, "/mnt/data/barry/projects/Schroeter_Pcinnamomi/Timecourse analysis/TCAseq_Fasta/cluster_output.fasta")
cluster_5_genes.id <- gtf.faa.omicsbox[gtf.faa.omicsbox$gene_id %in% cluster_5_genes, ]
write_fasta_clusters(cluster_5_genes.id, 5, "/mnt/data/barry/projects/Schroeter_Pcinnamomi/Timecourse analysis/TCAseq_Fasta/cluster_output.fasta")
cluster_6_genes.id <- gtf.faa.omicsbox[gtf.faa.omicsbox$gene_id %in% cluster_6_genes, ]
write_fasta_clusters(cluster_6_genes.id, 6, "/mnt/data/barry/projects/Schroeter_Pcinnamomi/Timecourse analysis/TCAseq_Fasta/cluster_output.fasta")


```

run on PHIB-BLAST http://phi-blast.phi-base.org/
  use function to chunck clusters into 400 .fasta sequences as to not break their server
check  PHI-base 4.15 protein sequences
use the flags -evalue 1.0e-5 -num_alignments 20

```{r}
# Set the file path to your .tsv file
file_path <- "/mnt/data/barry/projects/Schroeter_Pcinnamomi/Timecourse analysis/PHIBLAST_results/1.1PHI-BLAST-std_tsv_report.tsv"

# Read the .tsv file into a data frame, excluding rows containing "# "
data <- read.delim(file_path, sep = "\t", header = FALSE)
data <- data[!grepl("# ", data$V1), , drop = FALSE]

# Create a new data frame to store the transformed data
transformed_data <- data.frame(matrix(ncol = 12, nrow = nrow(data) / 12, byrow = TRUE), row.names = NULL)

# Assign the values to the respective columns in the transformed data
transformed_data$protein_id <- data$V1[seq(1, nrow(data), 12)]
transformed_data$subject_id <- data$V1[seq(2, nrow(data), 12)]
transformed_data$percent_identity <- as.numeric(data$V1[seq(3, nrow(data), 12)])
transformed_data$alignment_length <- as.numeric(data$V1[seq(4, nrow(data), 12)])
transformed_data$mismatches <- as.numeric(data$V1[seq(5, nrow(data), 12)])
transformed_data$gap_opens <- as.numeric(data$V1[seq(6, nrow(data), 12)])
transformed_data$q_start <- as.numeric(data$V1[seq(7, nrow(data), 12)])
transformed_data$q_end <- as.numeric(data$V1[seq(8, nrow(data), 12)])
transformed_data$s_start <- as.numeric(data$V1[seq(9, nrow(data), 12)])
transformed_data$s_end <- as.numeric(data$V1[seq(10, nrow(data), 12)])
transformed_data$evalue <- data$V1[seq(11, nrow(data), 12)]
transformed_data$bit_score <- as.numeric(data$V1[seq(12, nrow(data), 12)])

transformed_data <- transformed_data[, -(1:12)]
transformed_data.id <- dplyr::right_join(gtf.omicsbox, transformed_data, by = 'protein_id')
phiunique <- as.data.frame(unique(transformed_data$protein_id)) 
names(phiunique)[1] <- "protein_id"

phiunique.id <- dplyr::right_join(gtf.faa.omicsbox, phiunique, by = 'protein_id')
```