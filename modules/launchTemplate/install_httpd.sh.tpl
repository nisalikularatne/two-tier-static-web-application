#!/bin/bash

########################################
##### USE THIS WITH AMAZON LINUX 2 #####
########################################

# get admin privileges
sudo su

# install httpd (Linux 2 version)
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
sudo aws s3 cp s3://${env}-acs730-finalproject-group15-bucket/images/nisali.jpg /var/www/html
sudo aws s3 cp s3://${env}-acs730-finalproject-group15-bucket/images/ashish.jpg /var/www/html
sudo aws s3 cp s3://${env}-acs730-finalproject-group15-bucket/images/prajesh.jpg /var/www/html
sudo aws s3 cp s3://${env}-acs730-finalproject-group15-bucket/images/sushma.jpg /var/www/html
echo "<!DOCTYPE html>
      <html>
      <head>
          <meta charset="utf-8">
          <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
          <link rel="shortcut icon" href="#">
          <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
          <title>Group 15</title>
      </head>
      <style media="screen">
          body {
              background-color: rgba(5, 12, 5, 0.32);
              font-size: 50pt;
              color: rgba(5, 12, 5, 0.65);
          }
      </style>
      <body>
      <div class="container-fluid">
          <div id="one" class="text-center">
              <span>Group15 ACS Project ${env}</span>
          </div>
        <div class="row">
                <div class="col-md-3 text-center">
                    <img src="nisali.jpg" width="350" height="600" alt="..." class="img-rounded">
                    <h2>Nisali Kularatne</h2>
                </div>
                <div class="col-md-3 text-center">
                    <img src="sushma.jpg" width="350" height="600" alt="..." class="img-rounded">
                    <h2>Sushma Choubey</h2>
                </div>
                <div class="col-md-3 text-center">
                    <img src="prajesh.jpg" width="350" height="600" alt="..." class="img-rounded">
                    <h2>Prajesh Puri</h2>
                </div>
                <div class="col-md-3 text-center">
                    <img src="ashish.jpg" width="350" height="600" alt="..." class="img-rounded">
                    <h2>Ashish Fatnani</h2>
                </div>
        </div>
      </div>
      </body>
      </html>

" > /var/www/html/index.html
