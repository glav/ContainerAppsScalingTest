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

#Import-Module "$PSScriptRoot\Function.psm1" -Force
Set-Location "$PSScriptRoot/../container/TestContainerApp"
$publishImageLocalPath = "$($ContainerAppName):$VersionTag"

Write-Host "Building docker image [$publishImageLocalPath]"
docker build -t $publishImageLocalPath .

$acrShortName = "acrtstae"
$acrFullName = "$acrShortName.azurecr.io"

Write-Host "Publishing container image to [$acrShortName]"

Write-Host "Logging into ACR [$acrShortName]"
## Login to ACR
az acr login --name $acrShortName

$imagePath="$acrFullName/$($ContainerAppName):$VersionTag"
#$localImage="$($ContainerAppName):dev"

Write-Host "Tagging local image [$publishImageLocalPath] with [$imagePath]"
## Tag image

docker tag $publishImageLocalPath $imagePath

Write-Host "Pushing image"
## And publish to ACR
docker push $imagePath
