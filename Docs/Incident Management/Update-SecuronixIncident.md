# Update-SecuronixIncident
Update a securonix incident.

## Syntax
```
Update-SecuronixIncident
    [-Url] <string>
    [-Token] <string>
    [-IncidentId] <string>
    [-ActionName] <string>
    [-Attributes <hashtable>]
```

## Description
Update-SecuronixIncident makes an API call to the Incident/Actions endpoint and updates an incident with the supplied action.

## Example

### Example 1: Take an action
Request
```
Update-SecuronixIncident -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-IncidentId '10029' -ActionName 'comment' \
-Attributes @{'comment'='comment message';'username'='jhalpert';'firstname'='Jim';'lastname'='Halpert'}
```
Response
```
{
    "status": "OK",
    "result": "submitted"
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

### -ActionName
A required API Parameter. Enter an action that you want to perform for the incident. You can run the Available Threat Actions on an Incident API to view the available actions.

### -Attributes
Depending on workflow configured in your organization, add the required attributes. Run Confirm-SecuronixIncidentAction, or Get-SecuronixIncidentActions to view all the attributes (required or not).

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)