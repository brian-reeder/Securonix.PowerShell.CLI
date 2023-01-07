# Confirm-SecuronixApiToken
Checks the validity of an API token with the Securonix Web API endpoint.

## Syntax
```
Confirm-SecuronixApiToken
    [-Url] <string>
    [-Token] <string>
```

## Description
Confirm-SecuronixApiToken makes an API call to the AUTH/Validate Securonix Web API with the supplied token. If the token is valid, the API will respond with "Valid".

## Example

### Example 1: Validate a token
Request
```
Confirm-SecuronixApiToken -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'
```

Response
```
Valid
```

### Example 2: Validate an invalid token
```
Confirm-SecuronixApiToken -Url 'DunderMifflin.securonix.com/Snypr' -Token '530bf219-5360-41d3-81d1-8b4d6f75956d'
```

Response
```
Invalid
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