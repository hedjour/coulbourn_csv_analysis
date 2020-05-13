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
  return(dataframe)
}
