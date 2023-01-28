# Get-SecuronixEntityThreatModel
Get an entities threat model.

## Syntax
```
Get-SecuronixEntityThreatModel
    [-Url] <string>
    [-Token] <string>]
    [-DocumentId] <string>
    [-TenantName <string>]
```

## Description
Get-SecuronixEntityThreatModel makes an API call to the sccWidget/GetEntityThreatDetails Securonix Web API with the supplied parameters. If the token and parameters are valid, the API responds with an object containing the entities threat model and policies violated.

## Examples

### Example 1: Get Details for a single tenant environment.
Request
```
Get-SecuronixEntityThreatModel -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -DocumentId '2^~A^~7|NULL|AW2385^~C^~1^~EP^~66)'
```

Response
```
{
    "Response": {
        "Total records": 1,
        "threats": [{
            "tenantid": 2,
            "tenantname": "India",
            "violator": "Activityaccount",
            "entityid": "AW2385",
            "resourcegroupname": "ADEventDataSecond28Oct2020",
            "threatname": "TM - Catch all activity accounts on 2nd AD Data set 28 Oct 2020",
            "category": "ALERT",
            "resourcename": "ADEVENTDATASECOND28OCT2020",
            "generationtime": "Wed, 28 Oct 2020 @ 07:25:40 AM",
            "generationtime_epoch": 1603887940344,
            "policies": [
                "Test_IEE_ActivityAccount",
                "Test_IEE_NetworkAddress"
            ]
        }]
    }
}
```

### Example 2: Get details for a MSSP environment
```
Get-SecuronixEntityThreatModel -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -DocumentId '2^~A^~7|NULL|AW2385^~C^~1^~EP^~66)' -TenantName 'PA-Scranton'
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

### -DocumentId
A required API Parameter, enter a RiskScore document ID.

### -TenantName
Enter the name of the tenant the threat model belongs to. This parameter is optional for non-MSSP.

## Links
[Securonix 6.4 REST API Categories - Security Command Center ](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#SecurityCommandCenterEndpoints)