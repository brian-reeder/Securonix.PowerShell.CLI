# Get-SecuronixIncident
Get incident details.

## Syntax
```
Get-SecuronixIncident
    [-Url] <string>
    [-Token] <string>
    [-IncidentId] <string>
```

## Description
Get-SecuronixIncident makes an API call to the Incident/Get endpoint and retrieves all details of an incident.

## Example

### Example 1: Get an incident
Request
```
Get-SecuronixIncident -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '100107'
```

Response
```
{
    "status": "OK",
    "messages": [
        "Get incident details for incident ID [100107]"
    ],
    "result": {
        "data": {
            "totalIncidents": 1.0,
                "incidentItems": [{
                "violatorText": "Cyndi Converse",
                "lastUpdateDate": 1566232568502,
                "violatorId": "96",
                "incidentType": "Policy",
                "incidentId": "100107",
                "incidentStatus": "COMPLETED",
                "riskscore": 0.0,
                "assignedUser": "Admin Admin",
                "priority": "low",
                "reason": [
                    "Resource: Symantec Email DLP",
                    "Policy: Emails with large File attachments",
                    "Threat: Data egress attempts"
                ],
                "violatorSubText": "1096",
                "entity": "Users",
                "workflowName": "SOCTeamReview",
                "url": "DunderMifflin.securonix.com/Snypr/configurableDashboards/view?&type=incident&id=100107",
                "isWhitelisted": false,
                "watchlisted": false
            }]
        }
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
Valid authentication token.

### -IncidentId
A required API Parameter, enter the incident id to view the details.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)