param containerAppEnvironmentName string = 'cae-test-ae'
param location string
param logAnalyticsWorkspaceName string
param appInsightsName string

resource resourceLogAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: logAnalyticsWorkspaceName
}

resource resourceAppInsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: appInsightsName
}

resource resourceContainerAppEnvironment 'Microsoft.App/managedEnvironments@2022-06-01-preview' = {
  name: containerAppEnvironmentName
  location: location
  sku: {
    name: 'Consumption'
  }
  properties: {
    daprAIConnectionString: resourceAppInsights.properties.ConnectionString
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: resourceLogAnalyticsWorkspace.properties.customerId
        sharedKey: resourceLogAnalyticsWorkspace.listKeys().primarySharedKey
      }
    }
    zoneRedundant: false
  }
}

output containerAppEnvironmentId string = resourceContainerAppEnvironment.id
output defaultDomain string = resourceContainerAppEnvironment.properties.defaultDomain
output staticIpAddress string = resourceContainerAppEnvironment.properties.staticIp
