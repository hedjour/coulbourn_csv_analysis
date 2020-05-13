names_state <- function(val){
  nameori <- c( "Start","Choice", "Immediate", "Delayed", "ITI")
  namesui <- c("Start","Choice", "Immediate", "Delayed", "DelayedPellet", "ITI")
      if (val == 0) {
      reponse = NA
    }else{
      flag = TRUE
      factors = 0
      while (flag) {
        if (factors == 0) {
          if ( val <= 5) {
            reponse = nameori[val]
            flag = FALSE
          }else{
            factors = factors + 1
          }
        }else {
          if (val <= 5 + 6 * factors) {
            #On cherche à retrouver la position de val dans les 6 valeur
            reponse = namesui[val - (((factors - 1) * 6) + 5)]
            flag = FALSE
          }else{
            factors = factors + 1
          }
        }#end of else
      }#end of while
    }#end of first if
    return(reponse)
  }

