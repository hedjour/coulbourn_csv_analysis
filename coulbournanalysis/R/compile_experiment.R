#' compile_experiment
#'
#' @param pathdir Path of a directory containing all directory with session
#'
#' @return
#' @export
#'
#' @examples
#'
compile_experiment <- function(pathdir){
  listesession <- list.dirs(path = pathdir, recursive = FALSE)
  output <- NULL
  # dfoutput <- sapply(listesession, FUN = function(x){
  #   dfi <- read_session(x)
  #   dfoutput <- dplyr::bind_rows(dfoutput, dfi)
  # })
  for (i in listesession) {
    print(i)
    dfi <- read_session(i)
    output <- dplyr::bind_rows(output, dfi)
  }
  return(output)
}
