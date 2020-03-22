# terraform-cloudcli

Terraform docker image with AWS/GCP/Azure CLI


## Usage

It is based on the light build of [python:3.8-alpine](https://hub.docker.com/_/python/) docker image.


## Installed tools

- [Terraform](https://www.terraform.io/downloads.html) (`terraform` : 0.12.24)
- [AWS CLI](https://github.com/aws/aws-cli) (`aws` : latest version when run the build)
- [Azure CLI](https://docs.microsoft.com/cli/azure/what-is-azure-cli) (`az` : latest version when run the build)
- [Google Cloud SDK](https://cloud.google.com/sdk/) (`gcloud` : latest version when run the build, also included `gsutil` , `bq`, `anthoscli` )

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (`kubectl` : latest version when run the build)
- [helm](https://github.com/helm/helm) (`helm` : v3.1.2)
- [aws-iam-authenticator](https://github.com/kubernetes-sigs/aws-iam-authenticator) (`aws-iam-authenticator` : 0.5.0)
- [eksctl](https://github.com/weaveworks/eksctl) (`eksctl` : latest version when run the build)
- [ansible](https://docs.ansible.com/ansible) (`ansible` : latest version when run the build, also included `ansible-playbook`, etc.)


You can use this image with the following:

`docker run --rm -it mungi/terraform-cloudcli  'terraform <command>'`

`docker run --rm -it mungi/terraform-cloudcli 'aws <command>'`
`docker run --rm -it mungi/terraform-cloudcli 'az <command>'`
`docker run --rm -it mungi/terraform-cloudcli 'gcloud <command>'`

`docker run --rm -it mungi/terraform-cloudcli 'kubectl <command>'`
`docker run --rm -it mungi/terraform-cloudcli 'helm <command>'`
`docker run --rm -it mungi/terraform-cloudcli 'eksctl <command>'`
`docker run --rm -it mungi/terraform-cloudcli 'aws-iam-authenticator <command>'`

`docker run --rm -it mungi/terraform-cloudcli 'ansible <command>'`

Should you have any questions or suggestions, please open an issue on github.
