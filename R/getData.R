getData <- function(module = "pregoes"
                    ,method = "pregoes"
                    ,format = "csv"
                    ,ParameterValueList = NULL
                    ,outFile = ifelse(format == "csv"
                                     ,"inMemory"
                                     ,paste(module
                                           , "_"
                                           , method
                                           , "_"
                                           , gsub(":", "_", Sys.time())
                                           , "."
                                           , format))
                    ,saveReq = FALSE) {

  destination <- buildURL(module, method, format, ParameterValueList)

  # To-Do: Implement direct to DB
  # To-Do: Implement streaming
  if (outFile == "inMemory") {
    req <- curl::curl_fetch_memory(destination)
  } else {
    req <- curl::curl_fetch_disk(destination, outFile)
  }

  if (saveReq) {
    req <<- req
  }

  message("URL timestamp: ", req$modified)
  message("Query status: ", req$status_code)
  if (req$status_code >= 200 && req$status_code < 300) {
    if (outFile == "inMemory") {
      return(req$content)
    } else {
      return(outFile)
    }
  } else {
    message("Result headers: ", req$headers)
    return(FALSE)
  }
}