# Three Tier App

This application is a static page app, service data from backend

### Tools Used
* Terraform 
* Kubernetes

## Local Run
Docker
```bash
cd application
docker-compose build
docker-compose up
```

## Environment Setup 
```bash
cd iaac/
terraform init
terraform plan
terraform apply
```

## Kubernetes Deployment 
```bash
cd manifests/
kubectl apply -f ./
```

### ECR Image Push
When code is pushed to master or PR is merged to master, github workflow runs and push the image to ECR

https://github.com/harisahmed001/three-tier-app/blob/master/.github/workflows/deploy.yml


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.