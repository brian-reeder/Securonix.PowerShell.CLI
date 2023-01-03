# New-SecuronixApiToken
Request a new API token from the Securonix Web API endpoint.

## Syntax
```
New-SecuronixApiToken
    [[-Url]<string>]
    [[-Username]<string>]
    [[-Password]<string>]
    [-Validity <int>]
```

## Description
New-SecuronixApiToken makes an API call to the AUTH/Generate Securonix Web API with the supplied credentials. If the user successfully authenticates, a token is provided.

## Example

### Example 1: Request an API token
Request
```
New-SecuronixApiToken -Url 'DunderMifflin.securonix.com/Snypr' -Username 'JimHalpert' -Password 'sEcUrEpAsSwOrD'
```

Response
```
530bf219-5360-41d3-81d1-8b4d6f75956d
```

### Example 2: Request an API token with access for 31 Days
```
New-SecuronixApiToken -Url 'Initech.securonix.com/Snypr' -Username 'MichaelBolton' -Password 'PiEcEsOfFlAiR'
```

Response
```
12345678-90AB-CDEF-1234-567890ABCDEF
```

## Parameters

### -Url
Url endpoint for your Securonix instance.
It must be in the following format:
```
https://<hostname or IPaddress>/Snypr
```
### -Username
Username for the account.

### -Password
Password for the account.

### -Validity
The number of days the token will be valid.
    
If unspecified, the default length is 365 days.

## Links
[Securonix 6.4 REST API Categories - Auth ](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Auth)