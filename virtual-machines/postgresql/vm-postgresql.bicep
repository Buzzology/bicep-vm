param namePrefix string
param subnetId string
param username string
param password string

var name = '${namePrefix}-pgsql'

module vm_pgsql '../general/vm-small/vm-small.bicep' = {
  name: name
  params: {
    namePrefix: name
    location: resourceGroup().location
    subnetId: subnetId
    ubuntuOsVersion: '18.04-LTS'
    osDiskType: 'Standard_LRS'
    vmSize: 'Standard_B1s'
    username: username
    password: password    
  }
}

output vmId string = vm_pgsql.outputs.id
