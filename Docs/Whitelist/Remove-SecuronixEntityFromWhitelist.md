# Remove-SecuronixEntityFromWhitelist
Create a new whitelist.

## Syntax
```
Remove-SecuronixEntityFromWhitelist
    [[-Url]<string>]
    [[-Token]<string>]
    [[-WhitelistName]<string>]
    [[-TenantName]<string>]
    [[-EntityId]<string>]
```
```
Remove-SecuronixEntityFromWhitelist
    [[-Url]<string>]
    [[-Token]<string>]
    [[-WhitelistName]<string>]
    [[-TenantName]<string>]
    [[-EntityIdList]<string[]>]
```

## Description
Remove-SecuronixEntityFromWhitelist makes an API call to the incident/removeFromWhitelist Securonix Web API. If successful, the entity is removed from the Global whitelist..

## Examples

### Example 1: Create a new Whitelist.
Request
```
Remove-SecuronixEntityFromWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WhitelistName 'test_whitelist' -TenantName 'PA-Scranton' \ 
-EntityType 'Users'
```

Response
```
New Global whitelist created successfully..!
```

### Example 1: Remove a user from a Global whitelist
Request
```
Remove-SecuronixEntityFromWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WhitelistName 'remote_users' -TenantName 'PA-Scranton' -EntityId 'jhalpert'
```

Response
```
Entity removed from whitelist Successfully ..!
```

### Example 2: Remove a list of ipaddresses from a Global Whitelist
Request
```
Remove-SecuronixEntityFromWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WhitelistName 'datacenter_ips' -TenantName 'NY-New_York_City' \
-EntityIdList @('192.168.0.1','172.16.0.1','10.0.0.1','127.0.0.1')
```

Response
```
Entity removed from whitelist Successfully ..!
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
A required API Parameter, the name of the tenant the whitelist belongs to.

### -EntityId
A required API Parameter, the id to remove from a whitelist.

| Entity Type | Entity Id    |
| ----------- | ------------ |
| User        | accountname  |
| Resources   | resourcename |
| IpAddress   | ipaddress    |

### -EntityIdList
A required API Parameter, a list of Entity Ids to remove from a watch list. Max number of 5 at a time.

## Links
[Securonix 6.4 REST API Categories - Whitelist Endpoints](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#WhitelistEndpoints)