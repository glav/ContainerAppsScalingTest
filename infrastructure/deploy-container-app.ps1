[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $ResourceGroup="ContainerAppTest",

    [Parameter()]
    [string]
    $VersionTag="v1",

    [Parameter()]
    [Int16]
    $MaxReplicas=1
)
$ErrorActionPreference = 'Stop'

Write-Host "Deploying conatiner app to resource group [$ResourceGroup]"

az deployment group create -f .\containerApp.bicep -g "$ResourceGroup" --parameters imageTag=$VersionTag maxReplicas=$MaxReplicas