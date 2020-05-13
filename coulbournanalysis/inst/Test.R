devtools::load_all()
get_subjects_responses("Datas/s01/1_2014_05_29__09_48_00.csv", session_number = "s01")
read_session(pathdir = "Datas/s01/")
read_session(pathdir = "Datas/190219 copy/")
donnees <- compile_experiment(pathdir = "./Datas/")
names_state(donnees, "./Datas/names.csv", "current state")
write.csv2(x = donnees, file = "Test.csv", na = "")
write.csv2(x = head(donnees,1000), file = "Test.csv", na = "")

#TODO ajouter l'appel à la fonction de modification des States à partir du fichier de trad

donnees$delay = purrr::map_dbl(donnees$`transition state`, define_loop)



#### Old code ####
#setnames(dataframe,3,'CorrectPort')
# dataframe = subset(dataframe, Protocol != 11 & ((CorrectPort > 1 & CorrectPort < 8) | (CorrectPort > 13 & CorrectPort < 19)))
# dataframe = melt(dataframe, c(1,2,3),variable.name = 'ResponsePort', value.name = 'NumResponses')

#### On regroupe les réponses en un dataframe ####
# data = aggregate(NumResponses ~ Protocol + Subject + CorrectPort + ResponsePort + CorrectResponse, data = data, FUN = sum)
# data = arrange(data,Protocol,Subject,CorrectResponse,CorrectPort,ResponsePort)
#### On ajoute la date à partir du nom du fichier aux données ####
# data$Date = as.Date(substr(file,1,6),'%m%d%y')
