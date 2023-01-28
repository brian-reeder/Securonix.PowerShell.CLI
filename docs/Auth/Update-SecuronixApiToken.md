# Update-SecuronixApiToken
Renews existing authentication token.

## Syntax
```
Update-SecuronixApiToken
    [-Url] <string>
    [-Token] <string>
```
Connection was set by Connect-SecuronixApi
```
Update-SecuronixApiToken
```

## Description
Update-SecuronixApiToken makes an API call to the AUTH/Renew Securonix Web API to renew the supplied token. If the token was renewed, the API will respond with "Success".

## Example

### Example 1: Update a token
Request
```
Update-SecuronixApiToken -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'
```

Response
```
Success
```

### Example 2: Validate an invalid token
```
Update-SecuronixApiToken -Url 'DunderMifflin.securonix.com/Snypr' -Token '530bf219-5360-41d3-81d1-8b4d6f75956d'
```

Response
```
Failure
```

### Example 3: Connect to the Securonix Api and update the connection length.
```
Connect-SecuronixApi -Instance 'dundermifflin' `
    -Username 'MichaelBolton' -Password 'PiEcEsOfFlAiR'

Update-SecuronixApiToken
```

Responses
```
Connected
Success
```

## Parameters

### -Url
Url endpoint for your Securonix instance.
It must be in the following format:
```
https://<hostname or IPaddress>/Snypr
```
### -Token
Valid authentication token.

## Links
[Securonix 6.4 REST API Categories - Auth](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Auth)