# Add-SecuronixEntityToWatchlist
Add an entity to a watchlist.

## Syntax
```
Add-SecuronixEntityToWatchlist
    [-Url] <string>
    [-Token] <string>
    [-WatchlistName] <string>
    [-EntityType] <string>
    [-EntityId] <string>
    [-ExpiryDays] <int>
    [-ResourceGroupId] <string>
```
```
Add-SecuronixEntityToWatchlist
    [-Url] <string>
    [-Token] <string>
    [-WatchlistName] <string>
    [-EntityType] <string>
    [-EntityIdList] <string[]>
    [-ExpiryDays] <int>
    [-ResourceGroupId] <string>
```
```
Add-SecuronixEntityToWatchlist
    [-Url] <string>
    [-Token] <string>
    [-WatchlistName] <string>
    -UsersId <string>
    -ExpiryDays <int>
```
```
Add-SecuronixEntityToWatchlist
    [-Url] <string>
    [-Token] <string>
    [-WatchlistName] <string>
    -UsersIdList <string[]>
    -ExpiryDays <int>
```
```
Add-SecuronixEntityToWatchlist
    [-Url] <string>
    [-Token] <string>
    [-WatchlistName] <string>
    -ActivityaccountId <string>
    -ExpiryDays <int>
    -ResourceGroupId <string>
```
```
Add-SecuronixEntityToWatchlist
    [-Url] <string>
    [-Token] <string>
    [-WatchlistName] <string>
    -ActivityaccountIdList <string[]>
    -ExpiryDays <int>
    -ResourceGroupId <string>
```
```
Add-SecuronixEntityToWatchlist
    [-Url] <string>
    [-Token] <string>
    [-WatchlistName] <string>
    -ResourceId <string>
    -ExpiryDays <int>
    -ResourceGroupId <string>
```
```
Add-SecuronixEntityToWatchlist
    [-Url] <string>
    [-Token] <string>
    [-WatchlistName] <string>
    -ResourceIdList <string[]>
    -ExpiryDays <int>
    -ResourceGroupId <string>
```
```
Add-SecuronixEntityToWatchlist
    [-Url] <string>
    [-Token] <string>
    [-WatchlistName] <string>
    -ActivityIpId <string>
    -ExpiryDays <int>
    -ResourceGroupId <string>
```
```
Add-SecuronixEntityToWatchlist
    [-Url] <string>
    [-Token] <string>
    [-WatchlistName] <string>
    -ActivityIpIdList <string[]>
    -ExpiryDays <int>
    -ResourceGroupId <string>
```

## Description
Add-SecuronixEntityToWatchlist makes an API call to the incident/addToWatchlist Securonix Web API and attempt to add the supplied entities as members to the watchlist.

## Examples

### Example 1: Add a user entity to a watchlist
Request
```
Add-SecuronixEntityToWatchlist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
    -WatchlistName 'Phished Users' -UsersId 'mscott' -ExpiryDays 90
```

Response
```
Add to watchlist successful..!
```

## Example 2: Add 5 activityip entities to a watchlist
Request
```
Add-SecuronixEntityToWatchlist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
    -WatchlistName 'Log4J Application Hosts' \
    -ActivityIpIdList @('127.0.0.1','192.168.1.1','172.16.1.1','10.1.1.1','172.31.255.255') \
    -EntityDays 90 -ResourceGroupId '83375'
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

### -WatchlistName
A required API Parameter, the name of the watchlist to add entity membership.

### -EntityType
A required API Parameter, enter the type of entity you are adding. May be the following types: 'Users', 'Activityaccount', 'Resource', 'Activityip'.

### -EntityId
A required API Parameter, the unique id to find watchlist memberships for. If the entitytype is users, the entityid will be the employeeid.

### -EntityIdList
A required API Parameter, a list of Entity Ids to add to a watchlist. Max number of 5 at a time. 

### -UsersId
A requried API parameter, enter the id for the Users entity to be added to a watchlist. This parameter sets EntityType to Users.

### -UsersIdList
A requried API parameter, enter a list of entity ids to be added to a watchlist. This parameter sets EntityType to Users.

### -ActivityaccountId
A requried API parameter, enter the id for the Activityaccount entity to be added to a watchlist. This parameter sets EntityType to Activityaccount.

### -ActivityaccountIdList
A requried API parameter, enter a list of entity ids to be added to a watchlist. This parameter sets EntityType to Activityaccount.

### -ResourceId
A requried API parameter, enter the id for the Resource entity to be added to a watchlist. This parameter sets EntityType to Resource.

### -ResourceIdList
A requried API parameter, enter a list of entity ids to be added to a watchlist. This parameter sets EntityType to Resource.

### -ActivityIpId
A requried API parameter, enter the id for the Activityip entity to be added to a watchlist. This parameter sets EntityType to Activityip.

### -ActivityIpIdList
A requried API parameter, enter a list of entity ids to be added to a watchlist. This parameter sets EntityType to ActivityIp.

### -ExpiryDays
A required API Parameter, enter the number of days for the account to be on the watchlist.

### -ResourceGroupId
A required API Parameter, enter the resource group id that the entity will be monitored from. If the resource type is Users, this will be set to -1.

## Links
[Securonix 6.4 REST API Categories - Watchlist ](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Watchlist)