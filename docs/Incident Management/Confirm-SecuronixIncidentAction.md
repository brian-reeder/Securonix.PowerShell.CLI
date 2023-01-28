# Confirm-SecuronixIncidentAction
Get available incident actions.

## Syntax
```
Confirm-SecuronixIncidentAction
    [-Url] <string>
    [-Token] <string>
    [-IncidentId] <string>
    [-Actioname] <string>
```

## Description
Confirm-SecuronixIncidentAction makes an API call to the Incident/Get endpoint and checks to see if an actions is possible, and returns with a list of parameters.

## Example

### Example 1: Verify Claim as an available action for an incident

Request
```
Confirm-SecuronixIncidentAction -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '100107' -ActionName 'Claim'
```

Response
```
{
    "status": "OK",
    "messages": [
        "Check if action is possible and get list of parameters - Incident Id - [100289], action Name - [CLAIM], - status - [Open]"
    ],
    "result": [{
        "actionDetails": [{
                "title": "Screen1",
                "sections": {
                    "sectionName": "Comments",
                    "attributes": [{
                            "displayName": "Comments",
                            "attributeType": "textarea",
                            "attribute": "15_Comments",
                            "required": false
                    }]
                }
        }],
        "actionName": "CLAIM",
        "status": "CLAIMED"
    }]
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
A required API Parameter, enter the target incident id.

### -Actioname
A required API Parameter, check to see if this action is available for an incident.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)