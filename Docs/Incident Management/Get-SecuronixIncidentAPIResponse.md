# Get-SecuronixIncidentAPIResponse
Make a request to Securonix API.

## Syntax

Get-SecuronixWorkflowsList
```
Get-SecuronixIncidentAPIResponse
    [-Url] <string>
    [-Token] <string>
    [-type] <string>
```

Get-SecuronixIncident, Get-SecuronixIncidentStatus, Get-SecuronixIncidentWorkflowName, Get-SecuronixIncidentActionList, Get-SecuronixChildIncidents, Get-SecuronixIncidentActivityHistory
```
Get-SecuronixIncidentAPIResponse
    [-Url] <string>
    [-Token] <string>
    [-type] <string>
    [-incidentId] <string>
```

Confirm-SecuronixIncidentAction
```
Get-SecuronixIncidentAPIResponse
    [-Url] <string>
    [-Token] <string>
    [-type] <string>
    [-incidentId] <string>
    [-actionName] <string>
```

Get-SecuronixIncidentsList, Get-SecuronixIncidentAttachments
```
Get-SecuronixIncidentAPIResponse
    [-Url] <string>
    [-Token] <string>
    [-type] <string>
    [-from] <string>
    [-to] <string>
    [-rangeType] <string>
    [-status <string>]
    [-allowChildCases]
    [-max <int>]
    [-offset <int>]
```

Get-SecuronixWorkflowDefinition, Get-SecuronixWorkflowDefaultAssignee
```
Get-SecuronixIncidentAPIResponse
    [-Url] <string>
    [-Token] <string>
    [-type] <string>
    [-workflowname] <string>
```

## Description
Get-SecuronixIncidentAPIResponse makes an API call to the incident/Get endpoint with the supplied request type. Parameters vary based on the type of request your are making. It is recommended to use the alternative wrappers in this module. 

## Example

### Example 1: Get details for a Securonix incident.

Request
```
Get-SecuronixIncidentAPIResponse -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-Type 'metaInfo' -IncidentId '100107'
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

### Example 2: Get list of incidents in updated status within the time frame.

Request
```
Get-SecuronixIncidentsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-type 'list' \
-from '1566249473000' -to '1566335873000' -rangeType 'updated'
```

Response
```
{
    "status": "OK",
    "result": {
        "data": {
            "totalIncidents": 1.0,
            "incidentItems": [{
                "violatorText": "Cyndi Converse",
                "lastUpdateDate": 1566293234026,
                "violatorId": "96",
                "incidentType": "RISK MODEL",
                "incidentId": "100181",
                "incidentStatus": "COMPLETED",
                "riskscore": 0.0,
                "assignedUser": "Account Access 02",
                "assignedGroup": "Administrators",
                "priority": "None",
                "reason": [
                    "Resource: Symantec Email DLP"
                ],
                "violatorSubText": "1096",
                "entity": "Users",
                "workflowName": "SOCTeamReview",
                "url": "DunderMifflin.securonix.com/Snypr/configurableDashboards/view?&type=incident&id=100181",
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

### -type
A required API Parameter, enter the API type to view the details.

### -incidentId
A required API Parameter, enter the unique incident id number.

### -from
A required API Parameter, enter time starting point. Time (epoch) in ms.

### -to
A required API Parameter, enter time ending point. Time (epoch) in ms.

### -rangeType
A required API Parameter, enter the incident action status. Select any of updated,opened,closed.

### -status
An optional API Parameter, filter results by status.

### -allowChildCases
An optional API Parameter, used to receive the list of child cases associated with a parent case in the response.

### -max
An optional API Parameter, enter maximum number of records the API will display.

### -offset
An optional API Parameter, used for pagination of the request.

### -workflowname
A required API Parameter, enter the name of a Securonix workflow.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)