Welcome to my BIOS611 Project. 
======================================

I'm planning on analyzing data regarding rookie seasons 
of NBA players and their subsequent Hall-of-Fame status.  

Getting Started
======================================
This project requires that you have access to Docker.

First, build the Docker container by running the following:
```{r}
docker build . -t project
```

Next, run the following to start RStudio. Use the top command if you are using a Mac or 
Linux system. Use the bottom code if you are using a Windows system, and make sure to 
insert the full path for your present working directory where indicated. 
```{r}
docker run -v $(pwd):/home/rstudio/ --rm -p 8787:8787 project

docker run -v [present working directory]:/home/rstudio --rm -p 8787:8787 project
```

Open a browser and visit https://localhost:8787 to connect to RStudio.