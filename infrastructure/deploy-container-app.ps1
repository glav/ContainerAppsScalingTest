[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $ResourceGroup="ContainerAppTest"
)
$ErrorActionPreference = 'Stop'

Write-Host "Deploying conatiner app to resource group [$ResourceGroup]"

az deployment group create -f .\containerApp.bicep -g "$ResourceGroup" #--parameters apimName=$apimname certCommonName=$cn hostname=$cn