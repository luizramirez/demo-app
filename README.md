# Flask Hello World on AWS using Terraform

## Pre-requisites:

- Terraform v1.14
- Ansible
- AWS credentials
- SSH key-pair

## Description

In this example, we are creating an EC2 instance that is hosting a python application using flask. By default flask expose the service on port 5000. Since this is going to be publicly exposed,I am adding reverse proxy to allow incoming traffic on port 80.

## Relevant Notes

1) This is a simple solution using an EC2 with an Elastic IP to be publicly accesible. Using an EIP could help us if we want to create a DNS entry for it.
2) I am using ansible for configuration management, there are some packages that need to be installed and some configurations files that need to be created.
3) The python application is being exposed on port 5000 on the instance, but there is a reverse-proxy handling the connections to allow port 80 to recevie the request and proxy it to port 5000.
4) There is a systemd unit file configured that is managing the flask application, this will help us to have a better control over the service and also taking advatange of systemctl to restart the service in case of failures
5) While this is working properly for a demo, this is not to be considered to be a production setup. The configuration is desigend to manage only the default branch on the repo, lets say, if we need to deploy a new version of the service, we will have to re-create the instance causing some downtime ( using terraform destory and terraform apply and updating the ansible code to checkout a different branch). This can be solved using creating AMIs and using a launch configuration + autoscaling groups.

