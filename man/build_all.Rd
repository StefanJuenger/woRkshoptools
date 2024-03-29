% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/build_all.R
\name{build_all}
\alias{build_all}
\title{Build the sessions and exercises}
\usage{
build_all(
  sessions_home = "./content/sessions/",
  exercises_home = "./content/exercises/",
  build_all = FALSE
)
}
\arguments{
\item{sessions_home}{Character; path to the sessions folder}

\item{exercises_home}{Character; path to the exercises folder}

\item{build_all}{Logical; defines whether all sessions and exercises are built
or only those that have been modified. Relies on a CSV file containing checksums that is
created the first time \code{build_sesssion()} is used; default is
\code{FALSE}}
}
\description{
Builds the sessions and exercises and moves their files into the respective folders
}
