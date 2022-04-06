#!/bin/bash

# Login to IBMCloud Container Registry
ibmcloud cr login
ibmcloud ks cluster config --cluster syp-cluster

# Update and push the dockerized application
docker build -t my-express-app .
docker tag my-express-app de.icr.io/my-express-app/my-express-app
docker push de.icr.io/my-express-app/my-express-app

# Restart the kubenertes deployment
kubectl rollout restart deployment