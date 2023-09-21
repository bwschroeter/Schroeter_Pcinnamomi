#sample information associated with the countmatrix 

V1 <- c("BS01", "BS02", "BS03", 
        "BS04", "BS05", "BS06", 
        "BS07", "BS08", "BS09", 
        "BS010", "BS011", "BS012", 
        "BS013", "BS014", "BS015", 
        "BS016", "BS017", "BS018", 
        "BS019", "BS020", "BS021", 
        "BS022", "BS023", "BS024")
Sample <- c("LaH0_1", "LaH0_2", "LaH0_3",
            "LaH18_1", "LaH18_2", "LaH18_3",
            "LaH30_1", "LaH30_2", "LaH30_3",
            "LaH48_1", "LaH48_2", "LaH48_3",
            "PcHyp_1", "PcHyp_2", "PcHyp_3",
            "LaPc18_1", "LaPc18_2", "LaPc18_3",
            "LaPc30_1", "LaPc30_2", "LaPc30_3",
            "LaPc48_1", "LaPc48_2", "LaPc48_3")
Treatment <- c("Untreated", "Untreated", "Untreated",
               "Untreated", "Untreated", "Untreated",
               "Untreated", "Untreated", "Untreated",
               "Untreated", "Untreated", "Untreated",
               "Control", "Control", "Control",
               "Treated", "Treated", "Treated",
               "Treated", "Treated", "Treated",
               "Treated", "Treated", "Treated")

Stage <- c("Control", "Control", "Control",
           "Early", "Early", "Early",
           "Middle", "Middle", "Middle",
           "Late", "Late", "Late", 
           "Vegetative", "Vegetative", "Vegetative", 
           "Early", "Early", "Early",
           "Middle", "Middle", "Middle", 
           "Late", "Late", "Late")

Time <- c("0h", "0h", "0h", 
          "18h", "18h", "18h",
          "30h", "30h", "30h",
          "48h", "48h", "48h", 
          "0h", "0h", "0h", 
          "18h", "18h", "18h",
          "30h", "30h", "30h",
          "48h", "48h", "48h")


coldata <- data.frame(V1,
                      Sample,
                      Treatment, 
                      Stage,
                      Time,
                      stringsAsFactors = F)
                             

str(coldata)
  
  

write.table(coldata, file = "/mnt/data/barry/projects/Schroeter_Pcinnamomi/shared_scripts/sample_info.tsv",quote=FALSE,sep="\t")

