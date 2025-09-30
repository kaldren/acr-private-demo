DEPLOY_NAME=rgDeployment
LOCATION=eastus
PARAM_FILE=params/main.dev.bicepparam
ACR_NAME=crcontainersdemo2025
BACKEND_IMAGE=backend
BACKEND_TAG=latest
BACKEND_CONTAINER_APP_NAME=app-backend-dev

FRONTEND_IMAGE=frontend
FRONTEND_TAG=latest
FRONTEND_CONTAINER_APP_NAME=app-frontend-dev
RG_NAME=rg-containers-demo-dev

# az login -- Might need to login first. Uncomment if needed.

az deployment sub create \
  --name rgDeployment \
  --location eastus \
  --parameters params/main.dev.bicepparam deployContainerApp=false

# # Login to ACR
ACR_LOGIN_SERVER=$(az acr show -n $ACR_NAME --query loginServer -o tsv)
az acr build --registry $ACR_NAME \
  --image $BACKEND_IMAGE:$BACKEND_TAG \
  --file ../backend/Dockerfile ../backend

ACR_LOGIN_SERVER=$(az acr show -n $ACR_NAME --query loginServer -o tsv)
az acr build --registry $ACR_NAME \
  --image $FRONTEND_IMAGE:$FRONTEND_TAG \
  --file ../frontend/Dockerfile ../frontend

az deployment sub create \
  --name rgDeployment \
  --location eastus \
  --parameters params/main.dev.bicepparam deployContainerApp=true


