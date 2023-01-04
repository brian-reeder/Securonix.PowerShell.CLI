# Get-SecuronixTopThreats
Get a list of top threats from Securonix.

## Syntax
```
Get-SecuronixTopThreats
    [[-Url]<string>]
    [[-Token]<string>]
    [[-Days]<int>]
    [-Offset <int>]
    [-Max <int>]
```

```
Get-SecuronixTopThreats
    [[-Url]<string>]
    [[-Token]<string>]
    [[-Hours]<int>]
    [-Offset <int>]
    [-Max <int>]
```

## Description
Get-SecuronixThreats makes an API call to the sccWidget/GetTopThreats Securonix Web API with the supplied parameters. If the token and parameters are valid, the API responds with an object containing a list of top threats for the supplied time range.

## Examples

### Example 1: Get Top Threats for last 90 days.
Request
```
Get-SecuronixTopThreats -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Days 90
```

Response
```
{ 
    "Response": { 
        "Date range": [
            "Jun 11, 2018 11:18:09 AM", 
            "Sep 9, 2018 11:18:09 AM" 
        ], 
        "Total records": 8,
        "Docs": [
            {
                "Threat model id": 118,
                "Threat nodel name": "Patient Data Compromise", 
                "Description": "No of Stages: 4, Risk Scoring Scheme:STATIC, Weight:100.0",
                "Criticality": "Low",
                "No of violator": 1,
                "Generation time": 1532388410500
            },{ 
                "Threat model id": 194, 
                "Threat nodel name": "Privileged IT User-Sabotage",
                "Description": "No of Stages: 4, Risk Scoring Scheme:STATIC, Weight:100.0", 
                "Criticality": "Medium",
                "No of violator": 1,
                "Generation time": 1532372629487
            }
        ]
    }
}
```

### Example 2: Get Top Threats for last 12 Hours.
```
Get-SecuronixTopThreats -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Hours 12 -Max 10
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

### -Days
A required API Parameter, enter the number of days to search. Not required if specifying Hours.

### -Hours
A required API Parameter, enter the number of hours to search. Not required if specifying Days.

### -Offset
An optional API Parameter, used for pagination of the request.

### -Max
An optional API Parameter, enter maximum number of records the API will display.

## Links
[Securonix 6.4 REST API Categories - TopN ](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#TopN)