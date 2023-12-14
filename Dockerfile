FROM rocker/verse
RUN apt update && apt upgrade -y
RUN apt update && apt install -y ca-certificates
RUN apt update && apt install -y tk
RUN R -e "options(warn=2, repos='https://archive.linux.duke.edu/cran/'); \ 
    install.packages('deSolve', dependencies=TRUE)"
RUN R -e "options(warn=2, repos='https://archive.linux.duke.edu/cran/'); \
    install.packages('MASS', dependencies=TRUE)"
RUN R -e "options(warn=2, repos='https://archive.linux.duke.edu/cran/'); \
    install.packages('gbm', dependencies=TRUE)"
RUN R -e "options(warn=2, repos='https://archive.linux.duke.edu/cran/'); \
    install.packages('matlab', dependencies=TRUE)"
RUN R -e "options(warn=2, repos='https://archive.linux.duke.edu/cran/'); \
    install.packages('tinytex', dependencies=TRUE)"
RUN R -e "options(warn=2, repos='https://archive.linux.duke.edu/cran/'); \
    install.packages('caret', dependencies=TRUE)"
RUN R -e "options(warn=2, repos='https://archive.linux.duke.edu/cran/'); \
    install.packages('glmnet', dependencies=TRUE)"
RUN R -e "options(warn=2, repos='https://archive.linux.duke.edu/cran/'); \
    install.packages('pROC', dependencies=TRUE)"
RUN R -e "options(warn=2, repos='https://archive.linux.duke.edu/cran/'); \
    tinytex::tlmgr_install(c(\"wrapfig\",\"ec\",\"ulem\",\"amsmath\",\"capt-of\",\"hyperref\",\"iftex\",\"pdftexcmds\",\"infwarerr\", \"kvoptions\", \"epstopdf\", \"epstopdf-pkg\", \"hanging\",\"grfext\", \"etoolbox\",\"xcolor\",\"geometry\", \"float\"))"