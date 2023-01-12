# Add-SecuronixComment
Add a comment to an incident.

## Syntax
```
Add-SecuronixComment
    [-Url] <string>
    [-Token] <string>
    [-IncidentId] <string>
    [-Comment] <string>
    [-Username <string>]
    [-Firstname <string>]
    [-Lastname <string>]
```

## Description
Add-SecuronixComment makes an API call to the Incident/Actions endpoint and adds a comment.

## Example

### Example 1: Take an action
Request
```
Add-SecuronixComment -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-IncidentId '10029' -Comment 'This is a test'
```
Response
```
{
    "status": "OK",
    "messages": [
        "Add comment to incident id - [100289]"
    ],
    "result": true
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

### -Comment
A required parameter. Enter a message to add to an incident.

### -Username
An optional parameter. Enter the username of the user adding the comment.

### -Firstname
An optional parameter. Enter the first name of the user adding the comment.

### -Lastname
An optional parameter. Enter the last name of the user adding the comment.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)