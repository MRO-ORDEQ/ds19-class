# Fun with Functions

far_to_kel <- function(temp){
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  return(kelvin)
}

far_to_kel(32)

# Write a function of kelvin to celcius

kel_to_cel <- function(temp){
  celcius <- temp - 273.15
  return(celcius)
}

kel_to_cel(0)

# Assignments made within a function are only accessible within that function. They are not 
# added to the global environment namespace.


# Write a function converting fahrenheit to celcsius
# by reusing the fucntions above.


far_to_cel <- function(far){
  cel <- kel_to_cel(far_to_kel(far))
  return (cel)
}
far_to_cel(32)

far_to_cel_2 <- function(temp){
  kel <- far_to_kel(temp)
  cel <- kel_to_cel(kel)
  return(cel)
}

far_to_cel_2(32)


# 2 ways to for nesting of functions

# Defensive programming errors
# intentional errors to make sure others know why things work in the code


far_to_kel <- function(temp){
  if(!is.numeric(temp)) {
    stop("temp must be numeric")
  }
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  return(kelvin)
}

# custom error code when "text" entered

far_to_kel_2 <- function(temp){
  stopifnot(is.numeric(temp))
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  return(kelvin)
}

far_to_kel_2("13")

# another way to call error code


# use stopifnot() or if/not function to throw an error if "temp" is not a numeric value
# for far_to_cel function

far_to_cel_3 <- function(temp){
    if(!is.numeric(temp)) {
    stop("temp must be numeric")
  }
  kel <- far_to_kel(temp)
  cel <- kel_to_cel(kel)
  return(cel)
}

far_to_cel_3("13")
far_to_cel_3(0)


# to call a function...

source("code/Fun_With_Functions.R")
far_to_cel(32)

# check-out Roxygen package for more formalized way of documenting functions
