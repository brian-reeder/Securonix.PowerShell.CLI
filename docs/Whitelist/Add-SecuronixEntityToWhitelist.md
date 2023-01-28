# Add-SecuronixEntityToWhitelist
Add an entity to a Global whitelist.

## Syntax
```
Add-SecuronixEntityToWhitelist
    [-Url] <string>
    [-Token] <string>
    [-WhitelistName] <string>
    [-TenantName] <string>
    [-EntityType] <string>
    [-EntityId] <string>
    -ResourceName <string>
    -ResourceGroupId <string>
    [-ExpiryDate <string>]
```
```
Add-SecuronixEntityToWhitelist
    [-Url] <string>
    [-Token] <string>
    [-WhitelistName] <string>
    [-TenantName] <string>
    -UsersEntityId <string>
    [-ResourceName <string>]
    [-ResourceGroupId <string>]
    [-ExpiryDate <string>]
```
```
Add-SecuronixEntityToWhitelist
    [-Url] <string>
    [-Token] <string>
    [-WhitelistName] <string>
    [-TenantName] <string>
    -ActivitaccountEntityId <string>
    -ResourceName <string>
    -ResourceGroupId <string>
    [-ExpiryDate <string>]
```
```
Add-SecuronixEntityToWhitelist
    [-Url] <string>
    [-Token] <string>
    [-WhitelistName] <string>
    [-TenantName] <string>
    -ActivityipEntityId <string>
    [-ResourceName <string>]
    [-ResourceGroupId <string>]
    [-ExpiryDate <string>]
```
```
Add-SecuronixEntityToWhitelist
    [-Url] <string>
    [-Token] <string>
    [-WhitelistName] <string>
    [-TenantName] <string>
    -ResourcesEntityId <string>
    [-ResourceName <string>]
    [-ResourceGroupId <string>]
    [-ExpiryDate <string>]
```

## Description
Add-SecuronixEntityToWhitelist makes an API call to the incident/addToWhitelist Securonix Web API. If successful, the entity is added to the Global whitelist.

## Examples

### Example 1: Add an Activityaccount to a Global Whitelist
Request
```
Add-SecuronixEntityToWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WhitelistName 'remote_users' -TenantName 'PA-Scranton' \
-ActivityaccountId 'jhalpert' \
-ResourceName 'dundermifflin_msft365_azuread' -ResourceGroupId '35' \
-ExpiryDate '05/16/2013'
```

Response
```
Data added to whitelist successfully...!
```

### Example 2: Add an IP address to a Global Whitelist
Request
```
Add-SecuronixEntityToWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WhitelistName 'infosec_servers' -TenantName 'NY-New_York_City' \
-ActivityipEntityId '192.168.1.55'
```

Response
```
Data added to whitelist successfully...!
```

## Parameters

### -Url
Url endpoint for your Securonix instance.
It must be in the following format:
```
https://<hostname or IPaddress>/Snypr
```

### -Token
Valid authentication token.

### -WhitelistName
A required API Parameter, the name of the whitelist you want to add an entity to.

### -TenantName
A required API Parameter, the name of the tenant the whitelist belongs to.

### -EntityType
A required API Parameter, enter the type of entity being added. It is recommended to use the following parameters instead: -UsersEntityType, -ActivityaccountEntityType, -ActivityipEntityType, -ResourcesEntityType. May be the following types: 'Users', 'Activityaccount', 'Activityip', 'Resources'.

### -EntityId
The entity id to to add a whitelist. Required for use with the EntityType parameter.

### -UsersEntityId
A required API Parameter, automatically specifies the EntityType as Users. Enter the entity id of the user being added. 

### -ActivityaccountEntityType
A required API Parameter, automatically specifies the EntityType as Activityaccount. Enter the entity id of the activityaccount being added.

### -ActivityipEntityType
A required API Parameter, automatically specifies the EntityType as Activityip. Enter the entity id of the activityip being added.

### -ResourcesEntityType
A required API Parameter, automatically specifies the EntityType as Resources. Enter the entity id of the resource being added.

### -ResourceName
This parameter is required if the EntityType is Activityaccount. Enter the resource name that an account belongs to.

### -ResourceGroupId
This parameter is required if the EntityType is Activityaccount. Enter the resourcegroupid assigned to the Resource the account belongs to.

### -ExpiryDate
An optional API Parameter, enter the date Securonix will remove the entity from the whitelist. Format: MM/DD/YYYY

## Links
[Securonix 6.4 REST API Categories - Whitelist Endpoints](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#WhitelistEndpoints)