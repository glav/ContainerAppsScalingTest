param location string
param appInsightsName string = 'appi-test-for-cae'
param logAnalyticsWorkspaceName string = 'la-test'

resource resourceLogAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  location: location
  name: logAnalyticsWorkspaceName
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}


resource resourceAppInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: resourceLogAnalyticsWorkspace.id
  }
}

output logAnalyticsId string = resourceLogAnalyticsWorkspace.id
output appInsightsId string = resourceAppInsights.id
output logAnalyticsName string = resourceLogAnalyticsWorkspace.name
output appInsightsName string = resourceAppInsights.name
