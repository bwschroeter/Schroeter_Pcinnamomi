library(reticulate)

#From python_activate.R script

Sys.setenv(PATH = paste("/home/barry/.local/bin", Sys.getenv("PATH"), sep = ":"))

#Download EffectorP_3.0.0-beta.zip from 
#https://github.com/JanaSperschneider/EffectorP-3.0/releases/tag/v3.0.0-beta

#upload and unzip

#use_python("/usr/bin/python3", required = TRUE)
#use_python("/home/barry/.virtualenvs/my-python/bin/python")

#path to where the 
setwd("~/projects/Schroeter_Pcinnamomi/PcEffector/EffectorP_3.0.0-beta/")

#system(paste(python_path, "EffectorP.py -i Effectors.fasta"))

#system("python EffectorP.py -i Effectors.fasta")

#system("/home/barry/.virtualenvs/my-python/bin/python EffectorP.py -i signalPpredicted.fasta")

# Specify the output file path
output_file <- "summary_table.txt"

# Run the EffectorP command and redirect the stdout to the output file
system("/home/barry/.virtualenvs/my-python/bin/python EffectorP.py -i signalPpredicted.fasta > summary_table.txt")

barry@ziemann-01:~/projects/Schroeter_Pcinnamomi/PcEffector/interproscan/interproscan-5.62-94.0
$ ./interproscan.sh -appl CDD,PANTHER,Pfam,PROSITEPATTERNS,PROSITEPROFILES,SFLD,SMART,TIGRFAM,Phobius,TMHMM,SUPERFAMILY 
-i /mnt/data/ba.fasta -iprlookup --goterms -b /mnt/data/barry/projects/Schroeter_Pcinnamomi/PcEffd.fasta -iprlookup --gos.fasta -iprlookup 
--goterms -b /mnt/data/barry/projects/Schroeter_Pcinnamomi/PcEffector/interproscan_output/
02/06/2023 16:10:02:589 Welcome to InterProScan-5.62-94.0
02/06/2023 16:10:02:590 Running InterProScan v5 in STANDALONE mode... on Linux
02/06/2023 16:10:07:662 RunID: ziemann-01_20230602_161007518_3u7w
02/06/2023 16:10:18:642 Loading file /mnt/data/barry/projects/Schroeter_Pcinnamomi/PcEffector/Raw_fasta/detected_genes.fasta
02/06/2023 16:10:18:643 Running the following analyses:
  [CDD-3.20,NCBIfam-11.0,PANTHER-17.0,Pfam-35.0,Phobius-1.01,ProSitePatterns-2022_05,ProSiteProfiles-2022_05,SFLD-4,SMART-9.0,SUPERFAMILY-1.75,TMHMM-2.0c]
Available matches will be retrieved from the pre-calculated match lookup service.

Matches for any sequences that are not represented in the lookup service will be calculated locally.
02/06/2023 16:10:22:280 Uploaded 13410 unique sequences for analysis
02/06/2023 16:13:43:306 87% completed
02/06/2023 17:13:43:416 21% completed
02/06/2023 18:13:43:432 50% completed
02/06/2023 18:26:42:402 100% done:  InterProScan analyses completed 


barry@ziemann-01:~/projects/Schroeter_Pcinnamomi/PcEffector/interproscan/interproscan-5.62-94.0$ ./interproscan.sh -appl CDD,PANTHER,Pfam,PROSITEPATTERNS,PROSITEPROFILES,SFLD,SMART,TIGRFAM,Phobius,TMHMM,SUPERFAMILY -i /mnt/data/barry/projects/Schroeter_Pcinnamomi/PcEffector/Raw_fasta/test.fasta -iprlookup --goterms -b /mnt/data/barry/projects/Schroeter_Pcinnamomi/PcEffector/interproscan_output/
  02/06/2023 16:07:36:133 Welcome to InterProScan-5.62-94.0
02/06/2023 16:07:36:134 Running InterProScan v5 in STANDALONE mode... on Linux
02/06/2023 16:07:41:369 RunID: ziemann-01_20230602_160741186_8a4l
02/06/2023 16:07:52:407 Loading file /mnt/data/barry/projects/Schroeter_Pcinnamomi/PcEffector/Raw_fasta/test.fasta
02/06/2023 16:07:52:408 Running the following analyses:
  [CDD-3.20,NCBIfam-11.0,PANTHER-17.0,Pfam-35.0,Phobius-1.01,ProSitePatterns-2022_05,ProSiteProfiles-2022_05,SFLD-4,SMART-9.0,SUPERFAMILY-1.75,TMHMM-2.0c]
Available matches will be retrieved from the pre-calculated match lookup service.

Matches for any sequences that are not represented in the lookup service will be calculated locally.
02/06/2023 16:08:04:916 25% completed
02/06/2023 16:08:19:519 54% completed
02/06/2023 16:08:28:868 77% completed
02/06/2023 16:08:41:425 91% completed
02/06/2023 16:08:52:328 100% done:  InterProScan analyses completed 
