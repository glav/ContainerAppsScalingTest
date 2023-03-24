param location string = resourceGroup().location

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
