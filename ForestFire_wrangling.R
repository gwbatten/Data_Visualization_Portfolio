library(stringr)
# import data
fire <- read.csv("data/ForestFiresOregon/FireList.csv", 
                 stringsAsFactors = FALSE)

fire <- fire[1:2500, ]

# remove incomplete cases
fire <- fire[complete.cases(fire), ]
fire <- fire[fire$Latitude != "" | fire$Longitude != "", ]


# remove weird characters
fire$Latitude <- str_replace_all(fire$Latitude, "ï¿½ï¿½", "°")
fire$Latitude <- str_replace_all(fire$Latitude, "ï¿½", "")
fire$Latitude <- str_replace_all(fire$Latitude, " ", "")

fire$Longitude <- str_replace_all(fire$Longitude, "ï¿½ï¿½", "°")
fire$Longitude <- str_replace_all(fire$Longitude, "ï¿½", "")
fire$Longitude <- str_replace_all(fire$Longitude, " ", "")

for (i in 1:dim(fire)[1]){
        if ((substr(fire$Longitude[i], 1, 1)) != "-"){
                fire$Longitude[i] <- paste0("-", fire$Longitude[i])
        } 
}


write.csv(fire, "./data/ForestFiresOregon/FireList_edit.csv",
          row.names = FALSE)

