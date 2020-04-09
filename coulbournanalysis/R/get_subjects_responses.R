#' get_subjects_responses
#'
#' @param path_file path to a csv file
#' @param session_number session's identifiants
#' @importFrom stringr str_split str_extract
#' @importFrom data.table fread
#' @return a dataframe
#' @export
#'
#' @examples
#'
get_subjects_responses = function(path_file, session_number){
  #Découpage du path_file pour obtenir les informations qui y sont contenue :
  filname <- tail( unlist(stringr::str_split(path_file, "/")),1)

  # Cette fonction lit un fichier csv et en modifie le contenu en fonction de l'expérience
  dataframe <- data.table::fread(path_file, select = c(5,8,9,10,11,12,13,14,15))
  dataframe$Subject <- substring(filname,1,1)
  dataframe$Date    <- stringr::str_extract(path_file, "([0-9]{4})_[0-9]{2}_[0-9]{2}")
  dataframe$Session <- session_number
  names(dataframe) <- stringr::str_to_lower(names(dataframe))
  orgacol <-  c(tail(names(dataframe),3), head(names(dataframe), length(names(dataframe)) - 3) )
  dataframe <- dataframe[, ..orgacol]


  #TODO ajouter l'appel à la fonction de modification des States à partir du fichier de trad

  return(dataframe)
  #### Old code ####
  #setnames(dataframe,3,'CorrectPort')
  # dataframe = subset(dataframe, Protocol != 11 & ((CorrectPort > 1 & CorrectPort < 8) | (CorrectPort > 13 & CorrectPort < 19)))
  # dataframe = melt(dataframe, c(1,2,3),variable.name = 'ResponsePort', value.name = 'NumResponses')

  #### On regroupe les réponses en un dataframe ####
  # data = aggregate(NumResponses ~ Protocol + Subject + CorrectPort + ResponsePort + CorrectResponse, data = data, FUN = sum)
  # data = arrange(data,Protocol,Subject,CorrectResponse,CorrectPort,ResponsePort)
  #### On ajoute la date à partir du nom du fichier aux données ####
  # data$Date = as.Date(substr(file,1,6),'%m%d%y')
}
