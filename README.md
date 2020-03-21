# terraform-cloudcli

Terraform docker image with AWS/GCP/Azure CLI


## Usage

This repository automatically builds containers for using terraform and AWS command line program. 
It is based on the light build of [python:3.8-alpine](https://hub.docker.com/_/python/) docker image.

You can use this image with the following:

`docker run --rm -it mungi/terraform-cloudcli  'terraform <command>'`  
or  
`docker run --rm -it mungi/terraform-cloudcli 'aws <command>'`
or  
`docker run --rm -it mungi/terraform-cloudcli 'gsutil <command>'`
or  
`docker run --rm -it mungi/terraform-cloudcli 'az <command>'`

Should you have any questions or suggestions, please open an issue on github.
