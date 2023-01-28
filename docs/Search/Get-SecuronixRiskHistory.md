# Get-SecuronixRiskHistory
Get a list of entries in the riskscorehistory index.

## Syntax
```
Get-SecuronixRiskHistory
    [-Url] <string>
    [-Token] <string>
    [[-Query] <string>]
```

## Description
Get-SecuronixRiskHistory prepares API parameters and queries the Securonix riskscorehistory index.

## Examples

### Example 1: Get risk score history for a user with employeeid 1129
Request
```
Get-SecuronixRiskHistory -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-Query 'employeeid = "1129"'
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

### -Query
A spotter query to be processed by Securonix. Valid indexes are: activity, violation, users, asset, geolocation, lookup, riskscore, riskscorehistory.

## Links
[Securonix 6.4 REST API Categories - Risk History](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#RiskHistory)