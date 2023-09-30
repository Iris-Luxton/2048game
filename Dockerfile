FROM nginx:alpine
# Set the working directory within the container
WORKDIR /usr/share/nginx/html
# Install Git
RUN apk update && apk add git
# Clone the Git repository into the container
RUN git clone https://github.com/Iris-Luxton/2048game.git && mv 2048game/* . && rm -rf 2048game
# daemon off means Nginx to run in the foreground when the container is started rather than background
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
# please note that including Dockerfile in the repo will not result in endless image building
# Dockerfile is separate from the image itself, and there is no extra setting to initiate another docker build -t appname
# However it is not common to include Docker file with source code. 