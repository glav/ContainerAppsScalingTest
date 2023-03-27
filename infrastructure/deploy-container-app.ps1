[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $ResourceGroup="ContainerAppTest"
)


az deployment group create -f .\main.bicep -g "$ResourceGroup" #--parameters apimName=$apimname certCommonName=$cn hostname=$cn