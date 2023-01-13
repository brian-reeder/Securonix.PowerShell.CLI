# Get-SecuronixIncidentActions
Get available incident actions.

## Syntax
```
Get-SecuronixIncidentActions
    [-Url] <string>
    [-Token] <string>
    [-IncidentId] <string>
```

## Description
Get-SecuronixIncidentActions makes an API call to the incident/Get endpoint and retrieves the actions available for an incident.

## Example

### Example 1: Get actions for an incident

Request
```
Get-SecuronixIncidentActions -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '100107'
```

Response
```
{
    "status": "OK",
    "messages": [
        "Get possible actions for incident ID [100289], incident status [Open]"
    ],
    "result": [
        {
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
        },{
            "actionDetails": [{
                "title": "Screen1",
                "sections": {
                    "sectionName": "Comments",
                    "attributes": [
                        {
                            "displayName": "Business Response",
                            "attributeType": "dropdown",
                            "values": [
                                "Inaccurate alert-User not a HPA",
                                "Inaccurate alert-inaccurate log data",
                                "Inaccurate alert-host does not belong to our business",
                                "Need more information",
                                "Duplicate alert"
                            ],
                            "attribute": "10_Business-Response",
                            "required": false
                        },{
                            "displayName": "Business Justification",
                            "attributeType": "text",
                            "attribute": "11_Business-Justification",
                            "required": false
                        },{
                            "displayName": "Remediation Performed",
                            "attributeType": "text",
                            "attribute": "12_Remediation-Performed",
                            "required": false
                        },{
                            "displayName": "Business Internal Use",
                            "attributeType": "text",
                            "attribute": "13_Business-Internal-Use",
                            "required": false
                        },{
                            "displayName": "Assign To Analyst",
                            "attributeType": "assignto",
                            "values": [
                                {
                                    "key": "GROUP",
                                    "value": "Administrators"
                                },{
                                    "key": "GROUP",
                                    "value": "SECURITYOPERATIONS"
                                },{
                                    "key": "USER",
                                    "value": "admin"
                                },{
                                    "key": "USER",
                                    "value": "auditor"
                                },{
                                    "key": "USER",
                                    "value": "useradmin"
                                },{
                                    "key": "USER",
                                    "value": "accessscanner"
                                },{
                                    "key": "USER",
                                    "value": "account08"
                                },{
                                    "key": "USER",
                                    "value": "account10"
                                },{
                                    "key": "USER",
                                    "value": "account06"
                                },{
                                    "key": "USER",
                                    "value": "account07"
                                },{
                                    "key": "USER",
                                    "value": "account02"
                                },{
                                    "key": "USER",
                                    "value": "account09"
                                },{
                                    "key": "USER",
                                    "value": "account01"
                                },{
                                    "key": "USER",
                                    "value": "account05"
                                },{
                                    "key": "USER",
                                    "value": "account03"
                                },{
                                    "key": "USER",
                                    "value": "account04"
                                }
                            ],
                            "attribute": "assigntouserid",
                            "required": true
                        }
                    ]
                }
            }],
            "actionName": "ASSIGN TO ANALYST",
            "status": "OPEN"
        },{
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
            "actionName": "ASSIGN TO SECOPS",
            "status": "OPEN"
        }
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
A required API Parameter, enter the incident id to view available actions.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)