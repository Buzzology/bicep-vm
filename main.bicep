targetScope = 'subscription' // tenant', 'managementGroup', 'subscription', 'resourceGroup'

param vmPgsqlUsername string
param vmPgsqlPassword string
param resourceGroupName string = 'not-set'
param namePrefix string = 'not set'


module vnet_generic './vnets/vnet-generic.bicep' = {
  name: 'vnet'
  scope: resourceGroup(resourceGroupName)
  params: {
    namePrefix: '${namePrefix}-vnet'
  }
}


module vm_pgsql './virtual-machines/postgresql/vm-postgresql.bicep' = {
  name: 'vm-pgsql'
  scope: resourceGroup(resourceGroupName)
  params: {
    namePrefix: '${namePrefix}-vm'
    subnetId: vnet_generic.outputs.subnetId
    username: vmPgsqlUsername
    password: vmPgsqlPassword
  }
}
 

output vmName string = vm_pgsql.name
