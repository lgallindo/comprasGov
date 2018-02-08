# Builds a URL to access SIASG open data.
#
# SIASG means SISTEMA INTEGRADO DE ADMINISTRAÇÃO DE SERVIÇOS GERAIS -
# Integrated General Services Management System, its the Brazilian
# federal government procurement system. It has open data that
# can be acquired using the URL template
# http://compras.dados.gov.br/{modulo}/v1/{metodo}.{formato}?{parametro1=valor1}&{parametro2=valor2}&{parametroN=valorN}
#
# This function builds those URLs.
#
#
buildURL <- function (module = "pregoes"
                      ,method = "pregoes"
                      ,format = "csv"
                      ,ParameterValueList = NULL) {

  baseURL <- paste0("http://compras.dados.gov.br/"
                    ,module
                    ,"/v1/"
                    ,method
                    ,"."
                    ,format)

  # To-Do: Check for mandatory parameters
  mandatoryPars <- knownMethods %>%
    dplyr::filter(module == module
                  & method == method
                  & mandatory == "Yes")
  if (dim(mandatoryPars)[1] > 0) {
    print(mandatoryPars)
    flush.console()
  }

  if (!is.null(ParameterValueList)) {
    baseURL <- paste0(baseURL, "?")
    Parameters <- names(ParameterValueList)
    for (i in 1:length(Parameters)) {
      if (i > 1) {
        baseURL <- paste0(baseURL, "&")
      }
      baseURL <-
        paste0(baseURL, Parameters[i], "=", ParameterValueList[[Parameters[i]]])
    }
  }

  return(baseURL)
}