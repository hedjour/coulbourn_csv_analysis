#' compile_experiment
#'
#' @param pathdir Path of a directory containing all directory with session
#'
#' @return
#' @export
#'
#' @examples
#'
compile_experiment <- function(pathdir, filter = "all"){
  if (!dir.exists(pathdir)) {stop(paste("Verify this directory is inexistant :", pathdir))}
  listesession <- list.dirs(path = pathdir, recursive = FALSE)
  #On ajoute la possibiliter de filtrer la liste des sessions pour ne pas tout garder
  if (filter != "all") {
    listesession <- listesession[stringr::str_which(listesession, filter)]
  }
  return(purrr::map_df(list.dirs(path = pathdir, recursive = FALSE), read_session))
}
