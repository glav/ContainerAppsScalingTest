param containerRegistryname string = 'acrtstae'
param location string
param userManagedIdentityId string

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: containerRegistryname
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
    publicNetworkAccess: 'Enabled'
  }

  identity: {
    type: 'SystemAssigned, UserAssigned'
    userAssignedIdentities: {
      '${userManagedIdentityId}': {}
    }
  }
}
