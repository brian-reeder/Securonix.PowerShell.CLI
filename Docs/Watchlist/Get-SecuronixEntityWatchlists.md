# Get-SecuronixEntityWatchlists
Gets a list of all Watchlists for a given entity.

## Syntax
```
Get-SecuronixEntityWatchlists
    [-Url] <string>
    [-Token] <string>
    [-EntityId] <string>
    [[-WatchlistName] <string>]
```

## Description
Get-SecuronixEntityWatchlists makes an API call to the incident/checkIfWatchlisted Securonix Web API and retrieves a list of all watchlists that the supplied entity is a member of.

## Examples

### Example 1: Search for an entity in all watchlists
Request
```
Get-SecuronixEntityWatchlists -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-EntityId 'jhalpert'
```

Response
```
{
    "status": "OK",
    "messages": [
        "The entityId provided is a part of these watchlists :"
    ],
    "result": [
        "test_watchlist",
        "Recently_Phished"
    ]
}
```

## Example 2: Search for an entity in a watchlist
Request
```
Get-SecuronixEntityWatchlists -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-EntityId 'jhalpert' -WatchlistName 'test_watchlist'
```

Response
```
{
    "status": "OK",
    "messages": [
        "The entityId provided is a part of these watchlists : "
    ],
    "result": [
        "Test_watchlist"
    ]
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

### -EntityId
A required API Parameter, the unique id to find watchlist memberships for. If the entitytype is users, the entityid will be the employeeid.

## -WatchlistName
An optional API Parameter, the name of the watchlist to check for an entities membership.

## Links
[Securonix 6.4 REST API Categories - Watchlist](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Watchlist)