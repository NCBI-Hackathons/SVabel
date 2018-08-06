
#' @import data.table

#' @name addition
#' @title outputs the sum of two arguments
#' @description
#'
#' outputs the sum of two arguments
#' the inputs should be numeric
#'
#' @param arg1 numeric first argument
#' @param arg2 numeric second argument
#' @return numeric Sum 
#' @export
addition = function(arg1, arg2){

    dt = data.table()
    if(!is(arg1, 'numeric')){
    	stop("arg1 is not numeric")
    }
    if (!is(arg2, 'numeric')){
    	stop("arg2 is not numeric")
    }
    return(arg1+arg2)
}


