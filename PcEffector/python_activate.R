
#install.packages("reticulate")

library(reticulate)

#use_python("/usr/bin/python3")
#system("pip install torch matplotlib numpy tqdm")

setwd("~/projects/Schroeter_Pcinnamomi/PcEffector/signalp-6.0/signalp6_fast/")
#system("pip install signalp-6-package/")

Sys.setenv(PATH = paste("/home/barry/.local/bin", Sys.getenv("PATH"), sep = ":"))

SIGNALP_DIR <- system("python3 -c 'import signalp; import os; print(os.path.dirname(signalp.__file__))'", intern = TRUE)

#system(paste("cp -r ~/projects/Schroeter_Pcinnamomi/PcEffector/signalp-6.0/signalp6_fast/signalp-6-package/models/*", 
#             SIGNALP_DIR, "~/projects/Schroeter_Pcinnamomi/PcEffector/signalp-6.0/signalp6_fast/signalp-6-package/signalp/model_weights", sep = " "))




setwd("~/projects/Schroeter_Pcinnamomi/PcEffector/signalp-6.0/signalp6_slow_sequential/")

system(paste("cp -r ~/projects/Schroeter_Pcinnamomi/PcEffector/signalp6_slow_sequential/signalp-6-package/models/sequential_models_signalp6/*", 
             SIGNALP_DIR, "~/projects/Schroeter_Pcinnamomi/PcEffector/signalp6_slow_sequential/signalp-6-package/signalp/model_weights", sep = " "))

#Sys.setenv(PATH = paste("~/projects/Schroeter_Pcinnamomi/PcEffector/signalp-6.0/signalp6_fast/signalp-6-package/signalp", Sys.getenv("PATH"), sep = ""))
#Sys.setenv(PATH = paste("~/projects/Schroeter_Pcinnamomi/PcEffector/signalp-6.0/signalp6_fast/signalp-6-package/signalp/usr/bin:", Sys.getenv("PATH"), sep = ""))

#Sys.setenv(PATH = paste("/home/barry/.local/bin", Sys.getenv("PATH"), sep = ":"))




Sys.getenv("PATH")


system("signalp6 -h")
## detected genes
system("signalp6 --fastafile ~/projects/Schroeter_Pcinnamomi/PcEffector/Raw_fasta/detected_genes.fasta --organism eukarya --output_dir ~/projects/Schroeter_Pcinnamomi/PcEffector/SignalP_output --format none --mode fast")

##all genes
system("signalp6 --fastafile ~/projects/Schroeter_Pcinnamomi/PcEffector/Raw_fasta/all_pcgenes.fasta --organism eukarya --output_dir ~/projects/Schroeter_Pcinnamomi/PcEffector/SignalPall_output --format none --mode fast")

#system("signalp6 --fastafile ~/projects/Schroeter_Pcinnamomi/PcEffector/Raw_fasta/detected_genes.fasta --organism eukarya --output_dir ~/projects/Schroeter_Pcinnamomi/PcEffector/SignalP_output_slow --format none --mode slow-sequential")


#####
DEEPLOC
#####

#setwd("~/projects/Schroeter_Pcinnamomi/PcEffector/")

#system("pip install deeploc2_package/")
#setwd("~//mnt/data/barry/projects/Schroeter_Pcinnamomi/PcEffector/deeploc2_package/build/lib/DeepLoc2/")

#system("deeploc2 -f test.fasta")
