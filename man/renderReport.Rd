% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/renderReport.R
\name{renderReport}
\alias{renderReport}
\title{Generate a HTML report exploring a set of genomic regions}
\usage{
renderReport(regions, project, pvalueVars = c(`P-values` = "pval"),
  densityVars = NULL, significantVar = mcols(regions)$pval <= 0.05,
  annotation = NULL, nBestRegions = 500, customCode = NULL,
  outdir = "regionExploration", output = "regionExploration",
  browse = interactive(), txdb = NULL, device = "CairoPNG",
  template = NULL, ...)
}
\arguments{
\item{regions}{The set of genomic regions of interest as a \code{GRanges}
object. All sequence lengths must be provided.}

\item{project}{The title of the project.}

\item{pvalueVars}{The names of the variables with values between 0 and 1 to
plot density values by chromosome and a table for commonly used cutoffs.
Most commonly used to explore p-value distributions. If a named
character vector is provided, the names are used in the plot titles.}

\item{densityVars}{The names of variables to use for making density plots
by chromosome. Commonly used to explore scores and other variables given
by region.  If a named character vector is provided, the names are used in
the plot titles.}

\item{significantVar}{A \code{logical} variable differentiating statistically
significant regions from the rest. When provided, both types of regions
are compared against each other to see differences in width, location, etc.}

\item{annotation}{The output from \link[bumphunter]{matchGenes} used on
\code{regions}. Note that this can take time for a large set of regions
so it's better to pre-compute this information and save it.}

\item{nBestRegions}{The number of regions to include in the interactive
table.}

\item{customCode}{An absolute path to a child R Markdown file with code to be
evaluated before the reproducibility section. Its useful for users who want
to customize the report by adding conclusions derived from the data and/or
further quality checks and plots.}

\item{outdir}{The name of output directory.}

\item{output}{The name of output HTML file (without the html extension).}

\item{browse}{If \code{TRUE} the HTML report is opened in your browser once
it's completed.}

\item{txdb}{Specify the transcription database to use for identifying the
closest genes via \link[bumphunter]{matchGenes}. If \code{NULL} it will
use TxDb.Hsapiens.UCSC.hg19.knownGene by default.}

\item{device}{The graphical device used when knitting. See more at
http://yihui.name/knitr/options (\code{dev} argument).}

\item{template}{Template file to use for the report. If not provided, will
use the default file found in regionExploration/regionExploration.Rmd
within the package source.}

\item{...}{Arguments passed to other methods and/or advanced arguments.}
}
\value{
An HTML report with a basic exploration for the given set of
genomic regions.
}
\description{
This function generates a HTML report with quality checks, genome location
exploration, and an interactive table with the results. Other output formats
are possible such as PDF but lose the interactivity. Users can easily append
to the report by providing a R Markdown file to \code{customCode}, or can
customize the entire template by providing an R Markdown file to
\code{template}.
}
\examples{
## Load derfinder for an example set of regions
library('derfinder')
regions <- genomeRegions$regions

## Assign chr length
library('GenomicRanges')
seqlengths(regions) <- c('chr21' = 48129895)

## The output will be saved in the 'derfinderReport-example' directory
dir.create('renderReport-example', showWarnings = FALSE, recursive = TRUE)

## Generate the HTML report
report <- renderReport(regions, 'Example run', pvalueVars = c(
    'Q-values' = 'qvalues', 'P-values' = 'pvalues'), densityVars = c(
    'Area' = 'area', 'Mean coverage' = 'meanCoverage'),
    significantVar = regions$qvalues <= 0.05, nBestRegions = 20,
    outdir = 'renderReport-example')

if(interactive()) {
    ## Browse the report
    browseURL(report)
}

\dontrun{
## Note that you can run the example using:
example('renderReport', 'regionReport', ask=FALSE)
}
}
\author{
Leonardo Collado-Torres
}

