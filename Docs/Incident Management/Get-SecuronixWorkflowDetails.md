# Get-SecuronixWorkflowDetails
Get details of a workflow.

## Syntax
```
Get-SecuronixWorkflowDetails
    [-Url] <string>
    [-Token] <string>
    [-WorkflowName] <string>
```

## Description
Get-SecuronixWorkflowDetails makes an API call to the Incident/Get endpoint and returns with the details for the specified workflow.

## Example

### Example 1: Get a list of all workflows.

Request
```
Get-SecuronixWorkflowDetails -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WorkflowName 'SOCTeamReview'
```

Response
```
{
    "status": "OK",
    "messages": [
        "Workflow Details"
    ],
    "result": {
        "SOCTeamReview": {
        "CLAIMED": [
            {
                "Status": "OPEN",
                "Action": "ASSIGN TO ANALYST"
            },{
                "Status": "COMPLETED",
                "Action": "ACCEPT RISK"
            },{
                "Status": "OPEN",
                "Action": "RELEASE"
            },{
                "Status": "CLOSED",
                "Action": "VIOLATION"
            },{
                "Status": "OPEN",
                "Action": "ASSIGN TO SECOPS"
            }
        ],
        "CLOSED": [
            {
                "Status": "PENDING VERIFICATION",
                "Action": "CLAIM"
            },{
                "Status": "OPEN",
                "Action": "ASSIGN TO ANALYST"
            },{
                "Status": "OPEN",
                "Action": "RELEASE"
            }
        ],
        "PENDING VERIFICATION": [{
            "Status": "COMPLETED",
            "Action": "VERIFY"
        }],
        "OPEN": [
            {
                "Status": "OPEN",
                "Action": "ASSIGN TO ANALYST"
            },{
                "Status": "CLAIMED",
                "Action": "CLAIM"
            },{
                "Status": "OPEN",
                "Action": "ASSIGN TO SECOPS"
            },{
                "Status": "Do Not Change",
                "Action": "WhiteList_Action"
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

### -WorkflowName
A required API Parameter, enter the name of a Securonix workflow.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)