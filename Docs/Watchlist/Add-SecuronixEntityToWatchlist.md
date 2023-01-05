# Add-SecuronixEntityToWatchlist
Add an entity to a watch list.

## Syntax
```
Add-SecuronixEntityToWatchlist
    [[-Url]<string>]
    [[-Token]<string>]
    [[-EntityId]<string>]
    [[-WatchlistName]<string>]
    [[-EntityType]<string>]
    [[-EntityDays]<int>]
    [[-ResourceGroupId]<string>]
```
```
Add-SecuronixEntityToWatchlist
    [[-Url]<string>]
    [[-Token]<string>]
    [[-EntityIdList]<string[]>]
    [[-WatchlistName]<string>]
    [[-EntityType]<string>]
    [[-EntityDays]<int>]
    [[-ResourceGroupId]<string>]
```

## Description
Add-SecuronixEntityToWatchlist makes an API call to the incident/addToWatchlist Securonix Web API and attempt to add the supplied entities as members to the watchlist.

## Examples

### Example 1: Add a user entity to a watch list
Request
```
Add-SecuronixEntityToWatchlist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
     -EntityId 'jhalpert' -WatchlistName 'test_watchlist' -EntityType 'Users' -EntityDays 90 -ResourceGroupId '-1'
```

Response
```
Add to watchlist successful..!
```

## Example 2: Add 5 users entities to a watch list
Request
```
Add-SecuronixEntityToWatchlist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
     -EntityId @('jhalpert','dshrute','pbeesley','mscott','mpalmer') \
     -WatchlistName 'test_watchlist' -EntityType 'Users' -EntityDays 90 -ResourceGroupId '-1'
```

Response
```
Add to watchlist successful..!
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

### -EntityId
A required API Parameter, the unique id to find watchlist memberships for. If the entitytype is users, the entityid will be the employeeid.

### -EntityIdList
A required API Parameter, a list of Entity Ids to add to a watch list. Max number of 5 at a time. 

### -WatchlistName
A required API Parameter, the name of the watchlist to add entity membership.

### -EntityType
A required API Parameter, enter the type of entity you are adding. May be the following types: 'Users', 'Activityaccount', 'Resource', 'Activityip'.
		
### -ExpiryDays
A required API Parameter, enter the number of days for the account to be on the watch list.

### -ResourceGroupId
A required API Parameter, enter the resource group id that the entity will be monitored from. If the resource type is Users, this will be set to -1.

## Links
[Securonix 6.4 REST API Categories - Watchlist ](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Watchlist)