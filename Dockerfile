# Using official python image as a parent image
FROM python:latest

# Updating dependencies & Installing packages
RUN apt-get update && apt-get install git -y && \
    apt -y install python3-pip && \
    pip install Flask && \
    apt upgrade -y

#Copying local files  app from GitHub repository
RUN git clone https://github.com/SterlingMcKinley/kuralabs_deployment_5.git

#Changing directories to the application
WORKDIR /kuralabs_deployment_5 

#Installing application dependancies 
RUN pip install -r requirements.txt
RUN pip install gunicorn

#exposing port for traffic
EXPOSE 8000

#run the application from the container
ENTRYPOINT python3 -m gunicorn -w 4 application:app -b 0.0.0.0:8000
