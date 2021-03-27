param namePrefix string = 'unique'
param location string = resourceGroup().location
param subnetId string
param ubuntuOsVersion string = '18.04-LTS'
param osDiskType string = 'Standard_LRS'
param vmSize string = 'Standard_B1s'
param username string
param password string

var vmName = '${namePrefix}${uniqueString(resourceGroup().id)}'

// Bring in the nic
module nic './vm-small-nic.bicep' = {
  name: '${vmName}-nic'
  params: {
    namePrefix: '${vmName}-hdd'
    subnetId: subnetId
  }
}

// Create the vm
resource vm_small 'Microsoft.Compute/virtualMachines@2019-07-01' = {
  name: vmName
  location: location
  zones: [
    '1'
  ]
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
      }
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: ubuntuOsVersion
        version: 'latest'
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: username
      adminPassword: password
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.outputs.nicId
        }
      ]
    }
  }
}

output id string = vm_small.id
