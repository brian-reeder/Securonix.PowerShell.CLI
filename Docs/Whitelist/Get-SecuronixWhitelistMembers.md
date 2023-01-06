# Get-SecuronixWhitelistMembers
Get a list of members in a Securonix whitelist.

## Syntax
```
Get-SecuronixWhitelistMembers
    [-Url] <string>
    [-Token] <string>
    [-WhitelistName] <string>
    [-TenantName] <string>
```

## Description
Get-SecuronixWhitelistMembers makes an API call to the incident/listWhitelistEntities Securonix Web API. If successful, the API will respond with a list of entities in a whitelist.

## Examples

### Example 1: Get a list of entities in a whitelist.
Request
```
Get-SecuronixWhitelistMembers -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WhitelistName 'test_policy_name' -TenantName 'PA-Scranton'
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
A required API Parameter, the name of the whitelist you want to find.

### -TenantName
A required API Parameter, the name of the tenant the whitelist belongs to.

## Links
[Securonix 6.4 REST API Categories - Whitelist Endpoints](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#WhitelistEndpoints)