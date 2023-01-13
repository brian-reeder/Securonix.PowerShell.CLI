# Add-SecuronixViolationScore
Add to the Violation Score.

## Syntax
```
Add-SecuronixViolationScore
    [-Url] <string>
    [-Token] <string>
    [-ScoreIncrement] <int>
    [-TenantName] <string>
    [-ViolationName] <string>
    [-PolicyCategory] <string>
    [-EntityType] <string>
    [-EntityName] <string>
    [-ResourceGroupName] <string>
    [-ResourceName] <string>
```

## Description
Add-SecuronixViolationScore makes an API call to the incident/updateViolationScore endpoint and adds ScoreIncrement to the Violation Score.

## Example

### Example 1: Add 1 to a Violation Score.

Request
```
Add-SecuronixViolationScore -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' `
    -ScoreIncrement 1 -TenantName 'Automationtenant' `
    -ViolationName 'policy' -PolicyCategory 'category' `
    -EntityType 'Users' -EntityName 'xyz' `
    -ResourceGroupname 'rgGroup' -ResourceName 'resource'
```

Response
```
{
	"status": "OK",
	"messages": [
		"Violation score updated for AA01MAC, Policyname:All Resources - AD04Dataset - 09 Nov 2020 by 5.0 from SOAR API'"
	],
	"result": []
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
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

### -ScoreIcrement
A required API parameter. Only accepts positive integers, enter the value to increase the violation score by.

### -TenantName
A required API parameter. The name of the tenant the entity belongs to.

### -ViolationName
A required API parameter. Name of the violation/policy to increase the violation score.

### -PolicyCategory
A required API parameter. Policy category name of the policy being acted on.

### -EntityType
A required API parameter. Type of entity, enter any of: Users, Activityaccount, Resources, IpAddress.

### -EntityName
A required API parameter. Entityid/name of the entity being added. accountname for Activityaccount, userid for Users, ipadress for ActivityIp, resourceName for resources.

### -ResourceGroupName
Required if EntityType is not Users. Enter the name of the resource group the entity belongs to.

### -ResourceName
Required if EntityType is not Users. Enter the name of the resource the entity belongs to.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)