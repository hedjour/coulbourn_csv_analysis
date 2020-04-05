get_subjects_responses = function(file, study_design){
  # Cette fonction lit un fichier csv et en modifie le contenu en fonction de l'expérience
  filename = paste(study,'/raw_data/', file,sep = "")
  data = fread(filename, skip = 1, select = c(4,8,10,11,13,15,27,29))
  setnames(data,3,'CorrectPort')
  data = subset(data, Protocol != 11 & ((CorrectPort > 1 & CorrectPort < 8) | (CorrectPort > 13 & CorrectPort < 19)))
  data = melt(data, c(1,2,3),variable.name = 'ResponsePort', value.name = 'NumResponses')
  #### On nomme les states en fonction de l'expérience ####
  data$ResponsePort = as.character(data$ResponsePort)
  data$ResponsePort[data$ResponsePort == 'A1'] = 1
  data$ResponsePort[data$ResponsePort == 'A2'] = 2
  data$ResponsePort[data$ResponsePort == 'A3'] = 3
  data$ResponsePort[data$ResponsePort == 'B1'] = 5
  data$ResponsePort[data$ResponsePort == 'B2'] = 4
  data$CorrectResponse = F; data$CorrectResponse[data$CorrectPort == 7] = T
  data$WhenResponse[data$CorrectPort < 7] = 'Port Light'
  data$WhenResponse[data$CorrectPort > 7] = 'Grace Period'
  data$CorrectPort[data$CorrectPort < 7] = data$CorrectPort[data$CorrectPort < 7] - 1
  data$CorrectPort[data$CorrectPort > 7] = data$CorrectPort[data$CorrectPort > 7] - 13
  data$CorrectPort[data$CorrectResponse] = data$ResponsePort[data$CorrectResponse]
  data$Protocol[data$Protocol == 13] = '500ms'
  data$Protocol[data$Protocol == 14] = '100ms'
  data$Protocol[data$Protocol == 17] = 'blink'
  #### On regroupe les réponses en un dataframe ####
  data = aggregate(NumResponses ~ Protocol + Subject + CorrectPort + ResponsePort + CorrectResponse, data = data, FUN = sum)
  data = arrange(data,Protocol,Subject,CorrectResponse,CorrectPort,ResponsePort)
  #### On ajoute la date à partir du nom du fichier aux données ####
  data$Date = as.Date(substr(file,1,6),'%m%d%y')
}
