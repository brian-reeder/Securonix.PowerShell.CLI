# Get-SecuronixSearchAPIResponse
Get a list of entries in the violation index.

## Syntax
```
Get-SecuronixSearchAPIResponse
    -Url <string>
    -Token <string>
    -query <string>
```

Get-SecuronixActivityEvents
```
Get-SecuronixSearchAPIResponse
    -Url <string>
    -Token <string>
    -query <string>
    -eventtime_from <string>
    -eventtime_to <string>
    [-tz <string>]
    [-max <int>]
    [-queryId]
```

Get-SecuronixViolationEvents
```
Get-SecuronixSearchAPIResponse
    -Url <string>
    -Token <string>
    -query <string>
    -generationtime_from <string>
    -generationtime_to <string>
    [-tz <string>]
    [-max <int>]
    [-queryId]
```

## Description
Get-SecuronixSearchAPIResponse prepares API parameters and queries the Securonix violation index.

## Parameters

### -Url
Url endpoint for your Securonix instance.
It must be in the following format:
```
https://<hostname or IPaddress>/Snypr
```

### -Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

### -query
A spotter query to be processed by Securonix. Valid indexes are: activity, violation, users, asset, geolocation, lookup, riskscore, riskscorehistory.

### -eventtime_from
Required to query the activity index. Enter the event time start range in format MM/dd/yyy HH:mm:ss.

### -eventtime_to
Required to query the activity index. Enter the event time end range in format MM/dd/yyy HH:mm:ss.

### -generationtime_from
Required to query the violation index. Enter the event time start range in format MM/dd/yyy HH:mm:ss.

### -generationtime_to
Required to query the violation index. Enter the event time end range in format MM/dd/yyy HH:mm:ss.

### -tz
Enter the timezone info. If empty, the application timezone will be selected.

### -max
Enter the number of records you want the REST API to return. Default: 1000, Max: 10000.

### -queryId
Used for paginating through the results in the specified duration to ge the next set of maximum records. When you run the query for the first time, the response has the queryId. You can use the queryId to look for records on a specific page.

## Links
[Securonix 6.4 REST API Categories - Violations](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Violations)