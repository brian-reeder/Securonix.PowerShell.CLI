# Get-SecuronixIncidentWorkflowName
Get incident workflow.

## Syntax
```
Get-SecuronixIncidentWorkflowName
    [-Url] <string>
    [-Token] <string>
    [-IncidentId] <string>
```

## Description
Get-SecuronixIncidentWorkflowName makes an API call to the Incident/Get endpoint and retrieves the workflow name of an incident.

## Example

### Example 1: Get status of an incident

Request
```
Get-SecuronixIncidentWorkflowName -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '100107'
```

Response
```
{
    "status": "OK",
    "messages": [
        "Get incident workflow for incident ID [100107] - [SOCTeamReview]"
    ],
    "result": {
        "workflow": "SOCTeamReview"
    }
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
A required API Parameter, enter the incident id to view the workflow name.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)