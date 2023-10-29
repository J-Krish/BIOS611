FROM rocker/verse
RUN apt update && apt upgrade -y
RUN apt install -y ca-certificates
RUN apt update && apt install -y man-db && rm -rf /var/lib/apt/lists/*
RUN yes|unminimize
RUN R -e "options(warn=2, repos='https://archive.linux.duke.edu/cran/'); install.packages('deSolve', dependencies=TRUE)"
RUN R -e "options(warn=2, repos='https://archive.linux.duke.edu/cran/'); install.packages('MASS', dependencies=TRUE)"
RUN R -e "options(warn=2, repos='https://archive.linux.duke.edu/cran/'); install.packages('gbm', dependencies=TRUE)"
RUN R -e "options(warn=2, repos='https://archive.linux.duke.edu/cran/'); install.packages('matlab', dependencies=TRUE)"