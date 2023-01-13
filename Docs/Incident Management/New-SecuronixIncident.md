# New-SecuronixIncident
Create a securonix incident.

## Syntax
```
New-SecuronixIncident
    [-Url] <string>
    [-Token] <string>
    [-ViolationName] <string>
    [-DatasourceName] <string>
    [-EntityType] <string>
    [-EntityName] <string>
    [-Workflow] <string>
    [-Comment <string>]
    [-EmployeeId <string>]
    [-Criticality <string>]
```

## Description
New-SecuronixIncident makes an API call to the Incident/Actions endpoint and creates a new incident.

## Example

### Example 1: Create a new incident.
Request
```
New-SecuronixIncident -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-ViolationName 'Repeated Visits to Potentially Malicious address' -DatasourceName 'Websense Proxy' \
-EntityType 'Activityip' -EntityName '134.119.189.29' -Workflow 'SOCTeamReview'
```

Response
```
{
    "status": "OK",
    "messages":[
        "Get incident details for incident ID [100317]"
    ],
    "result": {
        "data": {
            "totalIncidents": 1.0,
            "incidentItems": [{
                "violatorText": "134.119.189.29",
                "lastUpdateDate": 1566337840264,
                "violatorId": "134.119.189.29",
                "incidentType": "Policy",
                "incidentId": "100317",
                "incidentStatus": "Open",
                "riskscore": 3.0,
                "assignedUser": "Admin Admin",
                "priority": "low",
                "reason": [
                    "Policy: Repeated Visits to Potentially Malicious address",
                    "Threat: Possible C2 Communication"
                ],
                "entity": "Activityip",
                "workflowName": "SOCTeamReview",
                "url": "https://saaspocapp2t14wptp.securonix.net/Snypr/configurableDashboards/view?&type=incident&id=100317",
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
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

### -IncidentId
A required API Parameter. Enter the incident id of the incident to update.

### -ViolationName
A required API Parameter. Enter the violation policy name.

### -DatasourceName
A required API Parameter. Enter the resource group name.

### -EntityType
A required API Parameter. Enter any of the following types: Users, Activityaccount, RGActivityaccount, Resources, Activityip.

### -EntityName
A required API Parameter. Enter the accountname associated with the violation.

### -Workflow
A required API Parameter. Enter the workflow name.

### -Comment
An optional API Parameter. Enter an additional comment.

### -EmployeeId
An optional API Parameter. Enter the employee id.

### -Criticality
A required parameter. Enter the new criticality. Possible values: 'none','low','medium','high','custom'.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)