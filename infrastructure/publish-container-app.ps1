[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $VersionTag="v1",

    [Parameter()]
    [string]
    $ContainerAppName="testcontainerapp"
)
$ErrorActionPreference = 'Stop'

$acrShortName = "acrtstae"
$acrFullName = "$acrShortName.azurecr.io"

Write-Host "Publishing container image to [$acrShortName]"

Write-Host "Logging into ACR [$acrShortName]"
## Login to ACR
az acr login --name $acrShortName


$imagePath="$acrFullName/$($ContainerAppName):$VersionTag"
$localImage="$($ContainerAppName):dev"

Write-Host "Tagging local image [$localImage] with [$imagePath]"
## Tag image

docker tag $localImage $imagePath

Write-Host "Pushing image"
## And publish to ACR
docker push $imagePath
