param containerRegistryname string = 'acrtstae'
param location string
param managedIdentityName string = 'testmanagedidentity'

resource resourceManagedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' existing = {
  name: managedIdentityName
}

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
      '${resourceManagedIdentity.id}': {}
    }
  }
}

var acrPullDefinitionId = '7f951dda-4ed3-4680-a7ca-43fe172d538d'
resource resource_roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup().id, containerRegistryname, 'tst-AcrPull')
  properties: {
    principalId: resourceManagedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', acrPullDefinitionId)
  }
}

