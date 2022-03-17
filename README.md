# How to push simple Node/Express microservice to IBM Kubernetes.

## Dockerize the App

### Create Docker Image
Build the Image using the Dockerfile
`docker build -t my-express-app .`

### Verify Docker Image by running it
Run the node app and forward port 3000 to the host.
`docker run -it -p3000:3000 my-express-app`

## Upload the Image to IBM Container Registry
 - Login to IBM Cloud: `ibmcloud login`
 - Install container registry plugin: `ibmcloud plugin install container-registry`
 - Login Docker to IBM CR: `ibmcloud cr login`
 - Create new namespace for this project: `ibmcloud cr namespace-add my-express-app`
 - Tag the Image for CR upload: `docker tag my-express-app de.icr.io/my-express-app/my-express-app`
 - Push the Image: `docker push de.icr.io/my-express-app/my-express-app`

## Kubernetes Cluster

### Create the Cluster
 - Create cluster named `syp-cluster`: `ibmcloud ks cluster create classic --name syp-cluster`
 - Wait for the cluster to be fully up... 30 minutes later...
 - Get the cluster config: `ibmcloud ks cluster config --cluster syp-cluster`

### Upload deployment to cluster
 - Upload deployment.yaml to cluster: `kubectl apply -f deployment.yaml`
 - Verify running status: `kubectl get pods`
 - Create and expose the service: `kubectl expose deployment/my-express-app`
 - Start a proxy to make the service available locally: `kubectl proxy`
 - Open the app in the browser: `http://localhost:<proxy-port>/api/v1/namespaces/default/services/my-express-app/proxy/`