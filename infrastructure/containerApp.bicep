param containerAppResourceName string = 'ca-test-ae'
param containerRegistryName string = 'acrtstae'
param imageTag string = 'v1'
param appPort int = 5000
param imageName string = 'testcontainerapp'
param containerAppEnvironmentName string = 'cae-test-ae'
param managedIdentityName string = 'testmanagedidentity'
param location string = resourceGroup().location
param appInsightsName string = 'appi-test-for-cae'
param environment_variables array = []
param maxReplicas int = 1

// @secure()
// param app_insights_connectionstring string

var default_env = [ {
    name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
    value: resourceAppInsights.properties.ConnectionString // app_insights_connectionstring
  }
  // {
  //   name: 'AzureSettings__UserAssignedClientId'
  //   value: resource_managedIdentity.properties.clientId
  // }
]

var env = concat(default_env, environment_variables)

param app_resource object = {
  cpu: json('0.5')
  memory: '1.0Gi'
}
param app_scale object = {
  minReplicas: 1
  maxReplicas: maxReplicas
}

resource resourceAppInsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: appInsightsName
}

resource resourceContainerAppEnv 'Microsoft.App/managedEnvironments@2022-03-01' existing = {
  name: containerAppEnvironmentName
}

resource resource_containerRegistry 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' existing = {
  name: containerRegistryName
}

resource resource_managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2022-01-31-preview' existing = {
  name: managedIdentityName
}

resource resourceContainerApp 'Microsoft.App/containerApps@2022-06-01-preview' = {
  name: containerAppResourceName
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${resource_managedIdentity.id}': {}
    }
  }
  properties: {
    managedEnvironmentId: resourceContainerAppEnv.id
    configuration: {
      ingress: {
        external: true
        targetPort: appPort
      }
      dapr: {
        enabled: true
        appId: imageName
        appProtocol: 'http'
        appPort: appPort
      }
      registries: [
        {
          server: resource_containerRegistry.properties.loginServer
          identity: resource_managedIdentity.id
        }
      ]
    }
    template: {
      containers: [
        {
          image: '${resource_containerRegistry.properties.loginServer}/${imageName}:${imageTag}'
          name: imageName
          env: env
          resources: app_resource
          probes: [
            {
              type: 'Readiness'
              tcpSocket: {
                port: appPort
              }
              initialDelaySeconds: 3
              periodSeconds: 10
            }
          ]
        }
      ]
      scale: {
        minReplicas: 1
        maxReplicas: maxReplicas
        rules: [
          {
            name: 'concurrentrequestsrule'
            http: {
              metadata: {
                concurrentRequests: '10'
              }
            }
          }
        ]
      }
    }
  }
}

output containerFQDN string = resourceContainerApp.properties.configuration.ingress.fqdn
output containerPort int = resourceContainerApp.properties.configuration.ingress.exposedPort
output containerEnvironmentIpAddress string = resourceContainerAppEnv.properties.staticIp
