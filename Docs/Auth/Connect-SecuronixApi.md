# Connect-SecuronixApi
Request a new API token from the Securonix Web API endpoint.

## Syntax
```
Connect-SecuronixApi
    [-Url] <string>
    [-Username] <string>
    [-Password] <string>
    [[-Validity] <int>]
```
```
Connect-SecuronixApi
    [-Instance] <string>
    [-Username] <string>
    [-Password] <string>
    [[-Validity] <int>]
```

## Description
Connect-SecuronixApi makes an API call to the AUTH/Generate Securonix Web API with the supplied credentials. If the user successfully authenticates, a token is provided and environment variables are set for later use.

## Example

### Example 1: Request an API token
Request
```
Connect-SecuronixApi -Instance 'dundermifflin' `
    -Username 'MichaelBolton' -Password 'PiEcEsOfFlAiR'
```

Response
```
Connected
```

## Parameters

### -Url
Url endpoint for your Securonix instance.
It must be in the following format:
```
https://<hostname or IPaddress>/Snypr
```

### -Instance
Subdomain for your Securonix instance.

### -Username
Username for the account.

### -Password
Password for the account.

### -Validity
The number of days the token will be valid.
    
If unspecified, the default length is 365 days.

## Links
[Securonix 6.4 REST API Categories - Auth](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Auth)