FROM ubuntu:22.04
# apt-get udpate will update all packages to the ubuntu machine
RUN apt-get update 
# nginx is web server to host our game, curl is a command-line tool for making HTTP requests
RUN apt-get install -y nginx zip curl 
# daemon off means Nginx to run in the foreground when the container is started rather than background
RUN echo "daemon off;" >>/etc/nginx/nginx.conf
# the command below will zip our repo. The -o flag specifies the output file
# In this case, it indicates that the downloaded file should be saved as /var/www/html/main.zip
# -L: The -L flag tells curl to follow redirects. If the URL specified has redirects, curl will follow them and download the final file.
# URL where curl will download the file, points to ZIP archive of GitHub repo (https://github.com/Iris-Luxton/2048game) on main branch. 
RUN curl -o /var/www/html/main.zip -L https://codeload.github.com/Iris-Luxton/2048game/zip/main
# the command below will unzip our repo
RUN cd /var/www/html/ && unzip main.zip && mv 2048-main/* . && rm -rf 2048-main main.zip 
# I would like to break things down:
# cd /var/www/html/: This command changes the current working directory within the container to /var/www/html/. 
# This is where the subsequent operations will take place.

EXPOSE 80

CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]