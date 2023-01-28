# Get-SecuronixTopViolationsList
Get a list of top threats from Securonix.

## Syntax
```
Get-SecuronixTopViolationsList
    [[-Url]<string>]
    [[-Token]<string>]
    [[-Days]<int>]
    [-Offset <int>]
    [-Max <int>]
```

```
Get-SecuronixTopViolationsList
    [[-Url]<string>]
    [[-Token]<string>]
    [[-Hours]<int>]
    [-Offset <int>]
    [-Max <int>]
```

## Description
Get-SecuronixTopViolationsList makes an API call to the sccWidget/GetTopViolations Securonix Web API with the supplied parameters. If the token and parameters are valid, the API responds with an object containing a list of top violations for the supplied time range.

## Examples

### Example 1: Get Top Threats for last 90 days.
Request
```
Get-SecuronixTopViolationsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Days 90
```

Response
```
{ 
    "Response": { 
        "Date range": [ 
            "Jun 11, 2018 11:25:55 AM", 
            "Sep 9, 2018 11:25:55 AM" 
        ],
        "Total records": 38,
        "Docs": [
            {
                "Policy id": 9237, 
                "Policy name": "Email to Competitor Domain", 
                "Criticality": "Medium", 
                "Violation entity": "Activityaccount", 
                "Policy category": "ALERT", 
                "Threat indicator": "Email to Competitor Domain", 
                "Generation time": 1533250072115, 
                "No of violator": 14, 
                "Description": "Email to Competitor Domain" 
            },{
                "Policy id": 9236, 
                "Policy name": "Abnormal number of emails sent to external domain as compared to peer members", 
                "Criticality": "Low", 
                "Violation entity": "Activityaccount", 
                "Policy category": "ALERT", 
                "Threat indicator": "Abnormal number of emails sent to external domain as compared to peer members", 
                "Generation time": 1533171483400, 
                "No of violator": 1, 
                "Description": "Abnormal number of emails sent to external domain as compared to peer members" 
            }
        ]
    }
}
```

### Example 2: Get Top Threats for last 12 Hours.
```
Get-SecuronixTopViolationsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Hours 12 -Max 10
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