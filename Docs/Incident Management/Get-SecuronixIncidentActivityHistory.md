# Get-SecuronixIncidentActivityHistory
Get a list of incident activity.

## Syntax
```
Get-SecuronixIncidentActivityHistory
    [-Url] <string>
    [-Token] <string>
    [-IncidentId] <string>
```

## Description
Get-SecuronixIncidentActivityHistory makes an API call to the incident/Get endpoint and retrieves a list of activity and actions taken on an incident.

## Example

### Example 1: Get history for an incident.
Request
```
Get-SecuronixIncidentActivityHistory -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-IncidentId '20019'
```
Response
```
{
    "status": "OK",
    "messages": [
        "Get activity stream details for incident ID [20019]"
    ],
    "result": {
        "activityStreamData": [{
            "caseid": "20019",
            "actiontaken": "CREATED",
            "status": "Open",
            "comment": [],
            "eventTime": "Jan 21, 2020 2:33:37 AM",
            "username": "Admin Admin",
            "currentassignee": "admin",
            "commentType": [],
            "currWorkflow": "SOCTeamReview"
        }]
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
A required API Parameter, enter the incident id to view the details.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)