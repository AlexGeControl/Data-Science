#
# Contents:
#   Peer Assessment Project for R Programming @ Coursera
# Author:
#   Alex Ge, alexgecontrol@qq.com
#

# Function:
#   makeCacheMatrix
# Description:
#   constructor for class CacheMatrix
makeCacheMatrix <- function( x = matrix( ) ) {
  #
  # Data:
  #
  invX <- NULL
  
  #
  # Methods:
  #
  # Function:
  #   set
  # Description:
  #   set matrix value
  set <- function( y ) {
    x <<- y
    invX <<- NULL
  }
  # Function:
  #   get
  # Description:
  #   get matrix value
  get <- function( ) { return( x ) }
  # Function:
  #   setInv
  # Description:
  #   set inverse matrix of x
  setInv <- function( invY ) {
    invX <<- invY
  }
  # Function:
  #   getInv
  # Description:
  #   get inverse matrix of x
  getInv <- function( ) { return( invX ) }
  
  # Create a new instance
  cacheMatrix <- list( set = set , get = get , setInv = setInv , getInv = getInv )
  class( cacheMatrix ) <- "CacheMatrix"
  
  return( cacheMatrix )
}


# Function:A
#   cacheSolve
# Description:
#   calculate inverse matrix for instances of CacheMatrix
cacheSolve <- function( x ) {
  # Get cached data:
  invX <- x$getInv( )
  if ( !is.null( invX ) ) {
    # If the result has been cached, then return directly:
    message( "[ CacheMatrix ]: Getting cached data" )
  } else {
    # Else calculate the inverse matrix: 
    invX <- solve( x$get( ) )
    x$setInv( invX )
  }
  # Return result:
  return( invX )
}
