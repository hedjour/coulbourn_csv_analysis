define_loop <- function(val){
  if (val == 0) {
    reponse = NA
  }else{
    flag = TRUE
    factors = 0
    while (flag) {
      if (factors == 0) {
        if ( val <= 5) {
          reponse = 0
          flag = FALSE
        }else{
          factors = factors + 1
        }
      }else {
        if (val <= 6 * factors) {
          reponse = (factors - 1) * 5
          flag = FALSE
        }else{
          factors = factors + 1
        }
      }#end of else
    }#end of while
    }#end of first if
  return(reponse)
}
