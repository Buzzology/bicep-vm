# Creating a VM on Azure with Bicep
A quick vm setup on Azure using Bicep.

## Blog post
https://whatibroke.com/2021/03/27/quick-sample-to-create-a-vm-azure-bicep/

## Run it
az deployment group create --template-file ./main.bicep  --parameters ./parameters/parameters.prod.json -g "{YOUR_RESOURCE_GROUP}"