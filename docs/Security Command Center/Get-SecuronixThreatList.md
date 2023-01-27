# Get-SecuronixThreatList
Get a list of threats from Securonix.

## Syntax
```
Get-SecuronixThreatList
    [-Url] <string>
    [-Token] <string>
    [-TimeStart] <string>
    [-TimeEnd] <string>
    [-Offset <int>]
    [-Max <int>]
    [-TenantName <string>]
```

## Description
Get-SecuronixThreatList makes an API call to the sccWidget/GetThreats Securonix Web API with the supplied parameters. If the token and parameters are valid, the API responds with an object containing a list of threats.

## Examples

### Example 1: Get Threats for a single tenant environment.
Request
```
Get-SecuronixThreatList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -TimeStart 299721600 -TimeEnd 299807999
```

Response
```
{
    "Response": {
        "Total records": 863778,
        "offset": 0,
        "max": 1000,
        "threats": [{
            "tenantid": 2,
            "tenantname": "a1t1said",
            "violator": "RTActivityAccount",
            "entityid": "TESTUSER-FEB 01 01:26:12-33593400",
            "resourcegroupname": "RG_TestA",
            "threatname": "Test_ThreatModel",
            "category": "ALERT",
            "resourcename": "TEST-HOST-QALAB.LOCAL",
            "resourcetype": "RT_TestA",
            "generationtime": "Tue, 1 Feb 2022 @ 02:06:23 AM",
            "generationtime_epoch": 1643702783965,
            "policies": [
                "Test_IEE_ActivityAccount",
                "Test_IEE_NetworkAddress"
            ]
        }]
    }
}
```

### Example 2: Get threats for a MSSP environment
```
Get-SecuronixThreatList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -TimeStart 299721600 -TimeEnd 299807999 -TenantName 'PA-Scranton'
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

### -TimeStart
A required API Parameter, enter starting point for the search. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS-00'.

### -TimeEnd
A required API Parameter, enter ending point for the search. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS-00'.

### -Offset
An optional API Parameter, used for pagination of the request.

### -Max
An optional API Parameter, enter maximum number of records the API will display.

### -TenantName
Enter the name of the tenant the threat model belongs to. This parameter is optional for non-MSSP.


## Links
[Securonix 6.4 REST API Categories - Security Command Center ](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#SecurityCommandCenterEndpoints)