# Get-SecuronixThreatActions
Get a list of available actions.

## Syntax
```
Get-SecuronixThreatActions
    [-Url] <string>
    [-Token] <string>
```

## Description
Get-SecuronixThreatActions makes an API call to the Incident/Get endpoint and retrieves all threat management actions available for an incident.

## Example

### Example 1: Get list of available threat management actions.
Request
```
Get-SecuronixThreatActions -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
```
Response
```
{
    "status": "OK",
    "messages": [
        "test Message 04"
    ],
    "result": [
        "Mark as concern and create incident",
        "Non-Concern",
        "Mark in progress (still investigating)"
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

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)