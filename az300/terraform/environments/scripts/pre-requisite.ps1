# Run set env script first, then run this script using -PARAMETER=$Env:PARAMETER
param (
    [Parameter(Mandatory)]$RESOURCE_GROUP,
    [Parameter(Mandatory)]$LOCATION,
    [Parameter(Mandatory)]$STORAGE_ACCOUNT,
    [Parameter(Mandatory)]$CONTAINER
)

# Before running an environment this script should run first

Write-Host "Login to azure"
# az login

Write-Host "Getting account list"
$account_list = az account list  | ConvertFrom-Json

Write-Host "Setting subscription"
az account set --subscription $account_list.id

Write-Host "Create resouce group ${RESOURCE_GROUP} in ${LOCATION}"
az group create --location $LOCATION --name $RESOURCE_GROUP

Write-Host "Create storage account ${STORAGE_ACCOUNT}"
az storage account create --name $STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP --location $LOCATION

Write-Host "Create container ${CONTAINER} into storage account ${STORAGE_ACCOUNT}"
az storage container create --name $CONTAINER --account-name $STORAGE_ACCOUNT 
