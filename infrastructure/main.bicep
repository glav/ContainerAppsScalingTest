param location string = resourceGroup().location
param managedIdentityName string = 'testmanagedidentity'

resource resourceManagedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' = {
  name: managedIdentityName
  location: location
}

module modDiagnostics 'diagnostics.bicep' = {
  name: 'diagnostics'
  params: {
    location: location
  }
}

module modContainerAppEnv 'containerEnvironment.bicep' = {
  name: 'containerappenv'
  params: {
    location: location
    appInsightsName: modDiagnostics.outputs.appInsightsName
    logAnalyticsWorkspaceName: modDiagnostics.outputs.logAnalyticsName
  }
}

module modContainerRegistry 'containerRegistry.bicep' = {
  name: 'containerregistry'
  params: {
    location: location
  }
}
