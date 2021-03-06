% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/json_schema.R
\name{json_schema}
\alias{json_schema}
\title{Create a schema for a JSON document or collection}
\usage{
json_schema(.x, type = c("string", "value"))
}
\arguments{
\item{.x}{a json string or \code{\link{tbl_json}} object}

\item{type}{whether to capture scalar nodes using the string that defines
their type (e.g., "logical") or as a representative value
(e.g., "true")}
}
\value{
a character string JSON document that represents the schema of
        the collection
}
\description{
Returns a JSON document that captures the 'schema' of the collection of
document(s) passed in, as a JSON string. The schema collapses complex
JSON into a simple form using the following rules:
}
\details{
\itemize{
  \item string  -> "string",        e.g., "a sentence" -> "string"
  \item number  -> "number",        e.g., 32000.1 -> "number"
  \item true    -> "logical",       e.g., true -> "logical"
  \item false   -> "logical",       e.g., false -> "logical"
  \item null    -> "null",          e.g., null -> "null"
  \item array   -> [<type>]         e.g., [1, 2] -> ["number"]
  \item object  -> {"name": <type>} e.g., {"age": 32} -> {"age": "number"}
}

For more complex JSON objects, ties are broken by taking the most
complex example (using \code{\link{json_complexity}}), and then by type
(using \code{\link{json_types}}).

This means that if a name has varying schema across documents, the
most complex schema will be chosen as being representative. Similarly,
if the elements of an array vary in schema, the most complex element is
chosen, and if arrays vary in schema across documents, the most
complex is chosen.

Note that \code{json_schema} can be slow for large JSON document collections,
you may want to sample your JSON collection first.
}
\examples{

# A simple string
'"string"' \%>\% json_schema \%>\% writeLines

# A simple object
'{"name": "value"}' \%>\% json_schema \%>\% writeLines

# A more complex JSON array
json <- '[{"a": 1}, [1, 2], "a", 1, true, null]'

# Using type = 'string' (default)
json \%>\% json_schema \%>\% writeLines

# Using type = 'value' to show a representative value
json \%>\% json_schema(type = "value") \%>\% writeLines

# Schema of the first 5 github issues
library(dplyr)
issues \%>\% gather_array \%>\% slice(1:10) \%>\%
  json_schema(type = "value") \%>\% writeLines
}
\seealso{
\code{\link{json_structure}} to recursively structure all
         documents into a single data frame
}

