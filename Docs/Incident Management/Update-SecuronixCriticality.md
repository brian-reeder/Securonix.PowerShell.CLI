# Update-SecuronixCriticality
Update an incidents criticality.

## Syntax
```
Update-SecuronixCriticality
    [-Url] <string>
    [-Token] <string>
    [-IncidentId] <string>
    [-Criticality] <string>
```

## Description
Update-SecuronixCriticality makes an API call to the Incident/Actions endpoint and updates the incidents criticality.

## Example

### Example 1: Take an action
Request
```
Update-SecuronixCriticality -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-IncidentId '10029' -Criticality 'low'
```
Response
```
{
    "status": "OK",
    "messages": [
        "Criticality updated for incidents : [1727657,172992]"
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

### -IncidentId
A required API Parameter. Enter the incident id of the incident to update.

### -Criticality
A required parameter. Enter the new criticality. Possible values: 'none','low','medium','high','custom'.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)