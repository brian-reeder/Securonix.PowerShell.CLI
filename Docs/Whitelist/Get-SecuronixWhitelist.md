# Get-SecuronixWhitelist
Get a list of Securonix whitelists.

## Syntax
```
Get-SecuronixWhitelist
    [-Url] <string>
    [-Token] <string>
    [-WhitelistName] <string>
    [[-TenantName] <string>]
```

## Description
Get-SecuronixWhitelist makes an API call to the incident/getlistofWhitelist Securonix Web API. If successful, the API will respond with a list of whitelists.

## Examples

### Example 1: Get a whitelist.
Request
```
Get-SecuronixWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WhitelistName 'test_policy_name' -TenantName 'PA-Scranton'
```

Response
```
{
	"status": "OK",
	"messages": [
		" WhiteList Name | Whitelist Type | Tenant Name "
	],
	"result": [
		" Whitelistname1 | whitelisttype1 | tenantname1 ",
		" Whitelistname2 | whitelisttype2 | tenantname2 ",
		" Whitelistname3 | whitelisttype3 | tenantname3 ",
		" Whitelistname4 | whitelisttype4 | tenantname4 ",  
	]
}
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
The name of the tenant the whitelist belongs to. This parameter is optional for non-MSSP.

## Links
[Securonix 6.4 REST API Categories - Whitelist Endpoints](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#WhitelistEndpoints)