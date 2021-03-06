#' R Client for Various CrossRef APIs.
#'
#' @section Crossref APIs:
#' rcrossref interacts with the main Crossref metadata search API at
#' <https://github.com/CrossRef/rest-api-doc/blob/master/rest_api.md>,
#' the old metadata search API at http://search.labs.crossref.org/, their
#' DOI Content Negotiation service at
#' <http://citation.crosscite.org/docs.html>, and
#' the \emph{Text and Data Mining} project <http://tdmsupport.crossref.org/>
#'
#' @section Defunct:
#' See [rcrossref-deprecated] and [rcrossref-defunct]
#' for details.
#'
#' @section What am I actually searching?:
#' When you use the `cr_*()` functions in this package, you are using
#' the Crossref search API described at
#' <https://github.com/CrossRef/rest-api-doc/blob/master/rest_api.md>.
#' When you search with query terms, on Crossref servers they are not searching
#' full text, or even abstracts of articles, but only what is available in the
#' data that is returned to you. That is, they search article titles, authors,
#' etc. For some discussion on this, see
#' <https://github.com/CrossRef/rest-api-doc/issues/101>.
#'
#' @section Rate limiting:
#' From time to time Crossref needs to impose rate limits to ensure that
#' the free API is usable by all. Any rate limits that are in effect will
#' be advertised in the `X-Rate-Limit-Limit` and
#' `X-Rate-Limit-Interval` HTTP headers.
#'
#' This boils down to: they allow X number of requests per some time period.
#' The numbers can change so we can't give a rate limit that will always
#' be in effect. If you're curious pass in `verbose = TRUE` to
#' your function call, and you'll get headers that will display these rate
#' limits.
#'
#' @section Text mining:
#' All Crossref specific text mining functions are now deprecated, and 
#' moved to a new package `crminer`.
#'
#' Another package \pkg{fulltext} is designed solely to do general purpose 
#' text mining involving Crossref and other sources of scholarly metadata 
#' and full text.
#'
#' @section High and Low Level APIs:
#' For the Crossref search API (the functions [cr_funders()],
#' [cr_journals()], [cr_licenses()],
#' [cr_members()], [cr_prefixes()], [cr_types()],
#' [cr_works()]), there is a high level API and a low level. The
#' high level is accessible through those functions just listed (e.g.,
#' [cr_works()]), whereas the low level is accessible via the same
#' fxn name with an underscore (e.g., [cr_works_()]). The high level
#' API does data requests, and parses to data.frame's. Since the high level
#' API functions have been around a while, we didn't want to break their
#' behavior, so the low level API functions are separate, and only do the data
#' request, giving back json or a list, with no attempt to parse any further. The
#' low level API functions will be faster because there's much less parsing, and
#' therefore less prone to potential errors due to changes in the Crossref API
#' that could cause parsing errors. Note that cursor feature works with both
#' high and low level.
#'
#' @section RStudio Addin:
#' On installation of \pkg{rcrossref} you get an RStudio Addin. To use the addin,
#' go to the top toolbar > Tools > Addins > Add Crossref Citations. You'll get a
#' window pop up that you can put in DOIs for. If the DOI is found, the bibtex
#' citations will be added to a file called `crossref.bib`. New citations
#' will be appended to that file. Addin authored by Hao Zhu
#' <https://github.com/haozhu233>
#' 
#' @section Be nice and share your email with Crossref:
#' The Crossref team encourage requests with appropriate contact information 
#' and will forward you to a dedicated API cluster for improved performance when 
#' you share your email address with them.
#' <https://github.com/CrossRef/rest-api-doc#good-manners--more-reliable-service>
#' 
#' To pass your email address to Crossref via this client, simply store it 
#' as environment variable in `.Renviron` like this:
#' 
#' 1. Open file:
#' `file.edit("~/.Renviron")`
#' 
#' 2. Add email address to be shared with Crossref
#' `crossref_email = name@example.com`
#' 
#' 3. Save the file and restart your R session
#' 
#' Don't wanna share your email any longer? Simply delete it from 
#' `~/.Renviron`
#'
#' @importFrom methods as
#' @importFrom utils modifyList packageVersion
#' @importFrom dplyr bind_rows tbl_df
#' @importFrom R6 R6Class
#' @importFrom xml2 read_xml xml_attr xml_find_all xml_find_first xml_text
#' @importFrom bibtex read.bib
#' @importFrom jsonlite toJSON fromJSON
#' @importFrom plyr llply ldply
#' @importFrom shiny h4 h5 fillRow htmlOutput renderUI textInput actionButton req
#' HTML observeEvent stopApp dialogViewer runGadget uiOutput actionLink icon
#' reactiveValues reactive includeCSS includeScript tags img addResourcePath
#' radioButtons textOutput renderText shinyApp strong updateActionButton
#' updateTextInput
#' @import miniUI
#' @importFrom DT datatable dataTableOutput renderDataTable
#' @importFrom stringr str_detect str_match
#' @name rcrossref-package
#' @aliases rcrossref
#' @docType package
#' @keywords package
NULL
