# Add-SecuronixAttributeToWhitelist
Add an entity to a Global whitelist.

## Syntax
```
Add-SecuronixAttributeToWhitelist
    [-Url] <string>
    [-Token] <string>
    [-WhitelistName] <string>
    [-TenantName] <string>
    [-ViolationType] <string>
    [-AttributeName] <string>
    [-AttributeValue] <string>
    [-ExpiryDate <string>]
```
```
Add-SecuronixAttributeToWhitelist
    [-Url] <string>
    [-Token] <string>
    [-WhitelistName] <string>
    [-TenantName] <string>
    [-ViolationType] <string>
    -SourceIp <string>
    [-ExpiryDate <string>]
```
```
Add-SecuronixAttributeToWhitelist
    [-Url] <string>
    [-Token] <string>
    [-WhitelistName] <string>
    [-TenantName] <string>
    [-ViolationType] <string>
    -ResourceType <string>
    [-ExpiryDate <string>]
```
```
Add-SecuronixAttributeToWhitelist
    [-Url] <string>
    [-Token] <string>
    [-WhitelistName] <string>
    [-TenantName] <string>
    [-ViolationType] <string>
    -TransactionString <string>
    [-ExpiryDate <string>]
```

## Description
Add-SecuronixAttributeToWhitelist makes an API call to the incident/addToWhitelist Securonix Web API. If successful, the attribute is added to the Attribute whitelist.

## Examples

### Example 1: Add an Ip Address to an Attribute Whitelist with an expiration date.
Request
```
Add-SecuronixAttributeToWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WhitelistName 'test_policy_name' -TenantName 'PA-Scranton' \
-ViolationType 'Policy' -SourceIp '192.168.0.1'
-ExpiryDate '05/16/2013'
```

Response
```
Data added to whitelist successfully...!
```

### Example 2: Add an resource to an Attribute Whitelist
Request
```
Add-SecuronixAttributeToWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WhitelistName 'functionality_name' -TenantName 'NY-New_York_City' \
-ViolationType 'Functionality' -ResourceType 'Microsoft Windows'
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
A required API Parameter, the name of the Attribute whitelist you want to add an entity to. This should match the target violation name based on your ViolationType: Policy name, ThreatModel name, or Functionality name.

### -TenantName
A required API Parameter, the name of the tenant the whitelist belongs to.

### -ViolationType
A required API Parameter, enter any of the following: "Policy", "ThreatModel", "Functionality"

### -AttributeName
A required API Parameter, enter the name of the attribute being added. It is recommended to use the following parameters instead: -sourceip, -resourcetype, -transactionstring. May be the following types: 'source ip', 'resourcetype', 'transactionstring'.

### -AttributeValue
The attribute value to add to an Attribute whitelist. Required for use with the AttributeName parameter.

### -SourceIp
A required API Parameter, automatically specifies the AttributeName as source ip. Enter the ip address to add to the Attribute whitelist. 

### -ResourceType
A required API Parameter, automatically specifies the AttributeName as resourcetype. Enter the resourcetype to add to the Attribute whitelist. 

### -TransactionString
A required API Parameter, automatically specifies the AttributeName as transactionstring. Enter the transactionstring to add to the Attribute whitelist. 

### -ExpiryDate
An optional API Parameter, enter the date Securonix will remove the entity from the whitelist. Format: MM/DD/YYYY

## Links
[Securonix 6.4 REST API Categories - Whitelist Endpoints](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#WhitelistEndpoints)