# Get-SecuronixWatchlistList
Gets a list of all Watchlists.

## Syntax
```
Get-SecuronixWatchlistList
    [[-Url]<string>]
    [[-Token]<string>]
```

## Description
Get-SecuronixWatchlistList makes an API call to the incident/listWatchlist Securonix Web API and retrieves a list of all watchlists.

## Examples

### Example 1: Create a new Watchlist.
Request
```
Get-SecuronixWatchlistList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'
```

Response
```
{
    "status": "OK",
    "messages": [
    "Get all existing watchlists."
    ],
    "result": {
        "Domain_Admin": "0",
        "Flight_Risk_Users_Watchlist": "0",
        "Recent_Transfers": "0",
        "Exiting_Behavior_Watchlist": "0",
        "Test_watchlist2": "0",
        "Bad_Performance_Review": "0",
        "Terminated_Contractors": "0",
        "Contractors-UpComing_Termination": "0",
        "Privileged_Accounts": "0",
        "Terminated_Employees": "0",
        "Test_watchlist": "2",
        "Privileged_Users": "0",
        "Recent_Hires": "0",
        "Employees-UpComing_Terminations": "0"
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
Valid authentication token.

## Links
[Securonix 6.4 REST API Categories - Watchlist ](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Watchlist)