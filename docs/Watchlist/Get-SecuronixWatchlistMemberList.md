# Get-SecuronixWatchlistMemberList
Gets a list members in a given watchlist.

## Syntax
```
Get-SecuronixWatchlistMemberList
    [-Url] <string>
    [-Token] <string>
    [-WatchlistName] <string>
```

## Description
Get-SecuronixWatchlistMemberList makes an API call to the incident/listWatchlistEntities Securonix Web API and retrieves a list of all members in the supplied watchlist.

## Examples

### Example 1: Get list of members in a watchlist.
Request
```
Get-SecuronixWatchlistMemberList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-WatchlistName 'test_watchlist'
```

Response
```
{
    "status": "OK",
    "messages": [
        "List of entities in the provided watchlist.",
        "Type : Users",
        "watchlistname : Test_watchlist",
        "Count : 2"
    ],
    "result": {
        "1002": "Users",
        "1001": "Users"
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

## -WatchlistName
A required API Parameter, the name of the watchlist to retrieve member list.

## Links
[Securonix 6.4 REST API Categories - Watchlist](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Watchlist)