% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/align_p_val.R
\name{align_p_val}
\alias{align_p_val}
\title{align_p_val}
\usage{
align_p_val(seq_1, seq_2, scoringMat, gapOpen, gapExtend, B, type)
}
\arguments{
\item{seq_1}{A sequence of DNA or amino acids.  Ex: "ASEDLTI" or "GACT"}

\item{seq_2}{A second sequence of DNA or amino acids.  Ex: "AEDFGI" or "GACCT"}

\item{scoringMat}{A scoring matrix for the alignment. See ?pairwiseAlignment in library Biostrings for
details.}

\item{gapOpen}{A numeric value for the penalty for opening a gap. See ?pairwiseAlignment in 
library Biostrings for details.}

\item{gapExtend}{A numeric value for continuing a gap.  See ?pairwiseAlignment in library 
Biostrings for details.}

\item{B}{The number of bootstrap samples used in the p-value bootstrap calculation.}

\item{type}{The text 'global' or 'local'.  See ?pairwiseAlignment in library 
Biostrings for details.}
}
\value{
tt_0 The t-statistic for the original alignment.

tt_B A vector of t-statistics for B randomly generated alignments.

p_val The p-value, ie the proportion of randomization-based alignment scores that are
great than or equal to the original observed alignment score.  mean(tt_B >= tt_0).
}
\description{
This function computes a p-value for the alignment of two sequences.
Length(sequence1) must be <= length(sequence2) in the arguments.
}
\examples{
##EXAMPLE 1: AMINO ACID SEQUENCE ALIGNMENT
##Set up two sequences:
seq_1 <- "ASEDLTI"
seq_2 <- "AEEDFGI"
##Set up gap parameters:
gapOpen <- 0
gapExtend <- -2
##Set up scoring matrix: (Biostrings contains protein scoring matrices.  
##Can also manually set up your own scoring matrix; be sure to name rows and columns.)
source("http://bioconductor.org/biocLite.R")
biocLite("Biostrings")
library(Biostrings) 
data(PAM30) ##load PAM30 scoring matrix
myScoringMat <- "PAM30"
##Perform alignment and obtain p-value:
myAlignment <- pairwiseAlignment(seq_1, seq_2, substitutionMatrix = myScoringMat, 
 	gapOpening = gapOpen, gapExtension = gapExtend, type = "global", scoreOnly = FALSE)
pval_output <- align_p_val(seq_1, seq_2, myScoringMat, gapOpen, gapExtend, B = 1000, type='global')


##EXAMPLE 2: DNA SEQUENCE ALIGNMENT:
seq_1 <- "ACT"
seq_2 <- "GCAT"
myScoringMat <- matrix(c(3,-2,-2,-1,-2,2,0,-1,-2,0,2,-2,-1,-1,-2,1),nrow=4,byrow=T,
dimnames=list(c('A','C','T','G'),c('A','C','T','G')))
gapOpen <- 0
gapExtend <- -1
##Perform global alignment:
myAlignment <- pairwiseAlignment(seq_1, seq_2, substitutionMatrix = myScoringMat, 
 	gapOpening = gapOpen, gapExtension = gapExtend, type = "global", scoreOnly = FALSE)
pval_output <- align_p_val(seq_1, seq_2, myScoringMat, gapOpen, gapExtend, B = 1000, type='global')

}
\author{
Jennifer Starling
}
\keyword{alignment}
\keyword{genomics}
\keyword{sequence}

