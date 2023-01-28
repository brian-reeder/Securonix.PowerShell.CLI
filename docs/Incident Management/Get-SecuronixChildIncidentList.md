# Get-SecuronixChildIncidents
Get a list of children incidents.

## Syntax
```
Get-SecuronixChildIncidents
    [-Url] <string>
    [-Token] <string>
    [-ParentId] <string>
```

## Description
Get-SecuronixChildIncidentListmakes an API call to the Incident/Get endpoint and retrieves all children incident ids of an incident.

## Example

### Example 1: Get list of children incidents.

Request
```
Get-SecuronixChildIncidentList-Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-ParentId '20019'
```

Response
```
{
    "status": "OK",
    "messages": [
        "Get child case details for incident ID [20019]"
    ],
    "result": [
        "20046",
        "20073",
        "20100",
        "20127",
        "20154",
        "20181",
        "20208",
        "20235"
    ]
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

### -ParentId
A required API Parameter, enter the incident id to view the details.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)