# Get-SecuronixWorkflowsList
Get list of workflows.

## Syntax
```
Get-SecuronixWorkflowsList
    [-Url] <string>
    [-Token] <string>
```

## Description
Get-SecuronixWorkflowsList makes an API call to the Incident/Get endpoint and returns with a list of workflows.

## Example

### Example 1: Get a list of all workflows.
Request
```
Get-SecuronixWorkflowsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'
```

Response
```
{
    "status": "OK",
    "messages": [
        "Get all possible workflows"
    ],
    "result": {
        "workflows": [
            {
                "workflow": "SOCTeamReview",
                "type": "USER",
                "value": "admin"
            },{
                "workflow": "ActivityOutlierWorkflow",
                "type": "USER",
                "value": "admin"
            },{
                "workflow": "AccessCertificationWorkflow",
                "type": "USER",
                "value": "admin"
            }
        ]
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

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)