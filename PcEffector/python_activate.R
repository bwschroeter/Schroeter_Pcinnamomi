
#install.packages("reticulate")

library(reticulate)

use_python("/usr/bin/python3")

system("pip install torch matplotlib numpy tqdm")

setwd("~/projects/Schroeter_Pcinnamomi/PcEffector/signalp-6.0/signalp6_fast/")

system("pip install signalp-6-package/")

Sys.setenv(PATH = paste("/home/barry/.local/bin", Sys.getenv("PATH"), sep = ":"))


SIGNALP_DIR <- system("python3 -c 'import signalp; import os; print(os.path.dirname(signalp.__file__))'", intern = TRUE)

system(paste("cp -r ~/projects/Schroeter_Pcinnamomi/PcEffector/signalp-6.0/signalp6_fast/signalp-6-package/models/*", 
             SIGNALP_DIR, "~/projects/Schroeter_Pcinnamomi/PcEffector/signalp-6.0/signalp6_fast/signalp-6-package/signalp/model_weights", sep = " "))

Sys.setenv(PATH = paste("~/projects/Schroeter_Pcinnamomi/PcEffector/signalp-6.0/signalp6_fast/signalp-6-package/signalp", Sys.getenv("PATH"), sep = ""))
Sys.setenv(PATH = paste("~/projects/Schroeter_Pcinnamomi/PcEffector/signalp-6.0/signalp6_fast/signalp-6-package/signalp/usr/bin:", Sys.getenv("PATH"), sep = ""))

#Sys.setenv(PATH = paste("/home/barry/.local/bin", Sys.getenv("PATH"), sep = ":"))
Sys.getenv("PATH")


system("signalp6 -h")
system("signalp6 --fastafile ~/projects/Schroeter_Pcinnamomi/PcEffector/chunkoutput/output_1.fasta --organism eukarya --output_dir ~/projects/Schroeter_Pcinnamomi/PcEffector/chunkresults --format none --mode fast")



