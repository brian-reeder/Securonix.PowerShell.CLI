# Get-SecuronixWorkflowDefaultAssignee
Get default resource assigned to a workflow.

## Syntax
```
Get-SecuronixWorkflowDefaultAssignee
    [-Url] <string>
    [-Token] <string>
    [-WorkflowName] <string>
```

## Description
Get-SecuronixWorkflowDefaultAssignee makes an API call to the Incident/Get endpoint and retrieves the resource an incident will be assigned for the selected workflow.

## Example

### Example 1: Get a list of all workflows.
Request
```
Get-SecuronixWorkflowDefaultAssignee -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WorkflowName 'SOCTeamReview'
```

Response
```
{
    "status": "OK",
    "messages": [
        "Default assignee for workflow [SOCTeamReview] - [admin]"
    ],
    "result": {
        "type": "USER",
        "value": "admin"
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

### -WorkflowName
A required API Parameter, enter the name of a Securonix workflow.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)