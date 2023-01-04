# Get-SecuronixTopViolators
Get a list of top violators from the Securonix Command Center.

## Syntax
```
Get-SecuronixTopViolators
    [[-Url]<string>]
    [[-Token]<string>]
    [[-Days]<int>]
    [-Offset <int>]
    [-Max <int>]
```

```
Get-SecuronixTopViolators
    [[-Url]<string>]
    [[-Token]<string>]
    [[-Hours]<int>]
    [-Offset <int>]
    [-Max <int>]
```

## Description
Get-SecuronixTopViolators makes an API call to the sccWidget/GetTopViolators Securonix Web API with the supplied parameters. If the token and parameters are valid, the API responds with an object containing a list of top violations for the supplied time range.

## Examples

### Example 1: Get Top Violators for last 90 days.
Request
```
Get-SecuronixTopViolators -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Days 90
```

Response
```
{ 
    "Response": { 
        "Date range": [ 
            "Jun 11, 2018 11:28:44 AM", 
            "Sep 9, 2018 11:28:44 AM" 
        ], 
        "Total records": 10, 
        "Docs": [ 
            { 
                "Name": "212274BB375846F85252DBD2CCBE7AE4 8E2657AD25B3904CCC449C202598B9B0 ", 
                "Violator entity": "Users", 
                "Risk score": 202.4, 
                "Generation time": 1529035574167, 
                "Department": "E2DE4125FB3335921E1CC05ED00C504A1E0BBBA898C335B9BA10B29F657B9401\t"
            },{ 
                "Name": "ACF8393CF33B5115506E12D9520EDD15 0CC721E95079DA18955B82AA67F5A4F9 ", 
                "Violator entity": "Users", 
                "Risk score": 140.48, 
                "Generation time": 1532053492068, 
                "Department": "6A2B422B8F594566BA327664B83594383D1FDE1BF5ED4FC39165D247B21CBF50\t"
            },
        ]
    } 
}
```

### Example 2: Get Top Violators for last 12 Hours.
```
Get-SecuronixTopViolators -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Hours 12 -Max 10
```

### Example 3: Get Top Violators for a User in the last 7 days.
```
Get-SecuronixTopViolators -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Days 7 -Max 10 -Name 'Jim Halpert'
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

### -Name
An optional API Parameter, enter the name of the user to view related Top Violators.

## Links
[Securonix 6.4 REST API Categories - TopN ](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#TopN)