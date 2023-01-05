# New-SecuronixWatchlist
Create a new watchlist.

## Syntax
```
New-SecuronixWatchlist
    [[-Url]<string>]
    [[-Token]<string>]
    [[-WatchlistName]<string>]
```

## Description
New-SecuronixWatchlist makes an API call to the incident/createWatchlist Securonix Web API. If successful, a new watchlist is created in Securonix with the desired name.

## Examples

### Example 1: Create a new Watchlist.
Request
```
New-SecuronixWatchlist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WatchlistName 'test_watchlist'
```

Response
```
New watchlist created successfully..!
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

### -WatchlistName
A required API Parameter, the name of the watchlist you want to create.

## Links
[Securonix 6.4 REST API Categories - Watchlist ](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Watchlist)