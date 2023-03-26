param containerRegistryname string = 'acr-tst-ae'
param location string

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: containerRegistryname
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
    anonymousPullEnabled: true
    publicNetworkAccess: 'Enabled'
  }
}
