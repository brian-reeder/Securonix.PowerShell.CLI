# Get-SecuronixIncidentAttachments
Get a list of files attached to incidents.

## Syntax
```
Get-SecuronixIncidentAttachments
    [-Url] <string>
    [-Token] <string>
    [-IncidentId] <string>
    [[-AttachmentType] <string>]
```
```
Get-SecuronixIncidentAttachments
    [-Url] <string>
    [-Token] <string>
    [-IncidentId] <string>
    [-TimeStart] <string>
    [-TimeEnd] <string>
    [[-AttachmentType] <string>]
```

## Description
Get-SecuronixIncidentAttachments makes an API call to the Incident/attachments endpoint and retrieves attachments from an incident.

## Example

### Example 1: Get list of incidents in updated status within the time frame.

Request
```
Get-SecuronixIncidentAttachments -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-IncidentId '100107'
```

### Example 2: User doesn't have access to incident or incident tenant.

Request
```
Get-SecuronixIncidentAttachments -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-IncidentId '100107'
```

Response
```
{
    "error": "[User] do not have access to incident tenant",
    "type": "Bad Request",
    "code": "400"
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

### -AttachmentType
A required API Parameter, select any of: csv, pdf, txt.

## Links
[Securonix 6.4 REST API Categories - Incident Management](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement)