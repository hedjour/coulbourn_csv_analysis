#' read_session
#'
#' @param pathdir a string which is the path to the directory where are the csv files.
#' @importFrom stringr str_subset str_c
#' @importFrom dplyr bind_rows
#' @return a dataframe row bind of all csv files.
#' @export
#'
#' @examples not executed
#' read_session(toto/)
#'
read_session <- function(pathdir){
  if (!dir.exists(pathdir)) {stop(paste("Verify this directory is inexistant :", pathdir))}
  listefile <- stringr::str_subset(dir(path = pathdir), ".*csv")
  sessionNum <- tail( unlist(stringr::str_split(pathdir, "/")),1)
  dfoutput <- NULL
  for (i in listefile) {
    dfi <- get_subjects_responses( normalizePath(stringr::str_c(pathdir,i, sep = "/")),
                                   session_number =  sessionNum)
    dfoutput <- dplyr::bind_rows(dfoutput, dfi)
  }
  return(dfoutput)
}
