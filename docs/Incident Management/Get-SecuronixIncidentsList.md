# Get-SecuronixIncidentsList
Get a list of Securonix incidents.

## Syntax
```
Get-SecuronixIncidentsList
    [-Url] <string>
    [-Token] <string>
    [-TimeStart] <string>
    [-TimeEnd] <string>
    [-RangeType] <string>
    [-Status <string>]
    [-AllowChildCases]
    [-Max <int>]
    [-Offset <int>]
```

## Description
Get-SecuronixIncidentsList makes an API call to the Incident/Get endpoint and retrieves a list of incidents opened within the supplied time range and any additional filters provided.

## Example

### Example 1: Get list of incidents in updated status within the time frame.

Request
```
Get-SecuronixIncidentsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-TimeStart '1566249473000' -TimeEnd '1566335873000' -RangeType 'updated'
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

### -TimeStart
A required API Parameter, enter starting point for the search. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS-00'.

### -TimeEnd
A required API Parameter, enter ending point for the search. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS-00'.

### -RangeType
A required API Parameter, select any of updated|opened|closed.

### -Status
An optional API Parameter, filter results by status.

### -AllowChildCases
An optional API Parameter, enter true to receive the list of child cases associated with a parent case in the response. Otherwise, enter false. This parameter is optional.

### -Max
An optional API Parameter, enter maximum number of records the API will display.

### -Offset
An optional API Parameter, used for pagination of the request.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)