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

system("/home/barry/.virtualenvs/my-python/bin/python EffectorP.py -i allSP.fasta > allSP_effectorPresults2.txt")


system(paste(python_path, "EffectorP.py -i Effectors.fasta"))

system("python EffectorP.py -i Effectors.fasta")

#system("/home/barry/.virtualenvs/my-python/bin/python EffectorP.py -i signalPpredicted.fasta")

# Specify the output file path
output_file <- "allSP_effectorPresults.txt"

# Run the EffectorP command and redirect the stdout to the output file
system("/home/barry/.virtualenvs/my-python/bin/python EffectorP.py -i allSP.fasta > allSP_effectorPresults.txt")

