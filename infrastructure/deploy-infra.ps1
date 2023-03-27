[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $ResourceGroup="ContainerAppTest"
)
$ErrorActionPreference = 'Stop'

$expiresTagValue = (get-date).AddDays(5).ToString('yyyy-MM-dd')

Write-Host "Creating resource group named [$ResourceGroup] which expires on [$expiresTagValue]"
az group create -n $ResourceGroup -l AustraliaEast --tags expiresOn=$expiresTagValue


az deployment group create -f .\main.bicep -g "$ResourceGroup" #--parameters apimName=$apimname certCommonName=$cn hostname=$cn