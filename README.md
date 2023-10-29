Welcome to my BIOS611 Project
======================================

I'm planning on analyzing data regarding rookie seasons of NBA players and their subsequent Hall-of-Fame status.

Getting Started
======================================
This project requires that you have access to Docker.

First, build the Docker container by running the following:
```{r}
docker build . -t project
```

Next, run one of the two following commands to start RStudio. 

Mac or Linux Users
-------------------
Insert a password of your choosing in the "[...]" below. If you prefer to 
use a system-generated password, delete "-e PASSWORD=[...]" from the code below.

```{r}
docker run -v $(pwd):/home/rstudio/work -e PASSWORD=[...] -e USERID=$(id -u) -e USERID=$(id -g)--rm -p 8787:8787 project
```

Windows Users
------------------
Be sure to replace '[present working directory]' below with the absolute path to
your present working directory.

Insert a password of your choosing in the "[...]" below. If you prefer to 
use a system-generated password, delete "-e PASSWORD=[...]" from the code below.

```{r}
docker run -v [present working directory]:/home/rstudio/work -e PASSWORD=[...] 
-e USERID=$(id -u) -e USERID=$(id -g) --rm -p 8787:8787 project
```

Open a browser and visit https://localhost:8787 to connect to RStudio. Use 
"rstudio" as the username and your specified password as your password. 
If you are using a system-generated password, copy and paste the 
generated password from your command prompt into the password field.