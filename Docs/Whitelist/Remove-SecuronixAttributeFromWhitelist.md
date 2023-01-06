# Remove-SecuronixAttributeFromWhitelist
Remove an entity from an Attribute whitelist.

## Syntax
```
Remove-SecuronixAttributeFromWhitelist
    [[-Url]<string>]
    [[-Token]<string>]
    [[-WhitelistName]<string>]
    [[-TenantName]<string>]
    [[-AttributeName]<string>]
    [[-AttributeValue]<string>]
```
```
Remove-SecuronixAttributeFromWhitelist
    [[-Url]<string>]
    [[-Token]<string>]
    [[-WhitelistName]<string>]
    [[-TenantName]<string>]
    [[-AttributeName]<string>]
    [[-AttributeValueList]<string[]>]
```

## Description
Remove-SecuronixAttributeFromWhitelist makes an API call to the incident/removeFromWhitelist Securonix Web API. If successful, the attribute or attributes are removed from the Attribute whitelist.

## Examples

### Example 1: Remove an accountname from an Attribute whitelist
Request
```
Remove-SecuronixAttributeFromWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WhitelistName 'remote_users' -TenantName 'PA-Scranton' \
-AttributeName 'accountname' -AttributeValue 'jhalpert'
```

Response
```
Entity removed from whitelist Successfully ..!
```

### Example 2: Remove a list of accountnames from an Attribute whitelist
Request
```
Remove-SecuronixAttributeFromWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WhitelistName 'remote_users' -TenantName 'PA-Scranton' \
-AttributeName 'accountname' -AttributeValueList @('jhalpert','dshrute','mscott')
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
A required API Parameter, the name of the whitelist to remove an attribute from.

### -TenantName
A required API Parameter, the name of the tenant the whitelist belongs to.

### -AttributeName
A required API Parameter, the name of an attribute being removed. Possible values include: accountname, transactionstring, sourcetype.

### -AttributeValue
A required API Parameter, the value of the attribute to remove from a whitelist.

### -AttributeValueList
A required API Parameter, a list of Attribute Values to remove from a white list. Max number of 5 at a time.

## Links
[Securonix 6.4 REST API Categories - Whitelist Endpoints](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#WhitelistEndpoints)