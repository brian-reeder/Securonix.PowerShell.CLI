# New-SecuronixWhitelist
Create a new whitelist.

## Syntax
```
New-SecuronixWhitelist
    [-Url] <string>
    [-Token] <string>
    [-WhitelistName] <string>
    [-TenantName] <string>
    [-EntityType] <string>
```

## Description
New-SecuronixWhitelist makes an API call to the incident/createGlobalWhitelist Securonix Web API. If successful, a new whitelist is created in Securonix with the desired name.

## Examples

### Example 1: Create a new Whitelist.
Request
```
New-SecuronixWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WhitelistName 'test_whitelist' -TenantName 'PA-Scranton' \ 
-EntityType 'Users'
```

Response
```
New Global whitelist created successfully..!
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
A required API Parameter, the name of the whitelist you want to create.

### -TenantName
A required API Parameter, the name of the tenant this whitelist should belong to.

### -EntityType
A required API Parameter, enter the type of entity thie whitelist is intended to hold. May be the following types: 'Users', 'Activityaccount', 'Resources', 'IpAddress'.

## Links
[Securonix 6.4 REST API Categories - Whitelist Endpoints](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#WhitelistEndpoints)