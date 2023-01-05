# Get-SecuronixWatchlistData
Get a list of entries in the watchlist index.

## Syntax
```
Get-SecuronixWatchlistData
    [[-Url]<string>]
    [[-Token]<string>]
    [-Query <string>]
```

## Description
Get-SecuronixWatchlistData makes an API call to the watchlist index in Spotter through Securonix Web API with the supplied parameters. If the token and parameters are valid, the API responds with an object containing a list of top violations for the supplied time range.

## Examples

### Example 1: Get a list of entries in the "Flight Risk Users" watchlist.
Request
```
Get-SecuronixWatchlistData -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -Query "watchlistname=`"Flight Risk Users`""
```

Response
```
{ 
    "available": "false", 
    "error": "false", 
    "events": [{ 
        "directImport": "false", 
        "hour": "0", 
        "ignored": "false", 
        "invalid": "false", 
        "invalidEventAction": "0", 
        "tenantid": "1", 
        "tenantname": "Securonix", 
        "u_id": "-1", 
        "u_userid": "-1", 
        "result": {
            "entry": [ 
                {
                    "key": "reason",
                    "value": ""
                },{
                    "key": "expirydate",
                    "value": "1540674976881"
                },{
                    "key": "u_employeeid",
                    "value": "1002"
                },{
                    "key": "u_department", 
                    "value": "Mainframe and Midrange Administration" 
                },{
                    "key": "u_workphone",
                    "value": "9728351246"
                },{
                    "key": "u_division",
                    "value": "Global Technology"
                },{
                    "key": "confidencefactor",
                    "value": "0.0"
                },{
                    "key": "entityname",
                    "value": "1002"
                },{
                    "key": "u_jobcode",
                    "value": "R1"
                },{
                    "key": "u_hiredate",
                    "value": "1249707600000"
                },{
                    "key": "type",
                    "value": "Users"
                },{
                    "key": "u_costcentername",
                    "value": "IINFCCC12"
                },{
                    "key": "expired",
                    "value": "false"
                },{
                    "key": "u_employeetypedescription",
                    "value": "FullTime"
                },{
                    "key": "tenantid",
                    "value": "2"
                },{
                    "key": "u_status",
                    "value": "1"
                },{
                    "key": "decayflag",
                    "value": "false"
                },{
                    "key": "u_lanid",
                    "value": "HO1002"
                },{
                    "key": "u_country",
                    "value": "USA"
                },{
                    "key": "u_title",
                    "value": "Associate Mainframe Administrator"
                },{
                    "key": "u_companycode",
                    "value": "TECH"
                },{
                    "key": "watchlistuniquekey",
                    value": "2^~Flight Risk Users|1002"
                },{
                    "key": "u_lastname",
                    "value": "OGWAL"
                },{
                    "key": "u_statusdescription",
                    "value": "Active"
                },{
                    "key": "u_firstname",
                    "value": "HOMER"
                },{
                    "key": "u_middlename",
                    "value": "B"
                },{
                    "key": "u_masked",
                    "value": "false"
                },{
                    "key": "u_employeetype",
                    "value": "FT"
                },{
                    "key": "watchlistname",
                    "value": "Flight Risk Users"
                },{
                    "key": "u_workemail",
                    "value": "HOMER.OGWAL@scnx.com"
                },{
                    "key": "u_manageremployeeid",
                    "value": "1001"
                },{
                    "key": "tenantname",
                    "value": "partnerdemo"
                },{
                    "key": "u_location",
                    "value": "LOS ANGELES"
                }
            ]
        }
    }] 
    "from": "1533842667887", 
    "offset": "1000", 
    "query": "index=watchlist AND watchlistname=\"Flight Risk Users\"", 
    "searchViolations": "false", 
    "to": "1536521067887", 
    "totalDocuments": "1" 
}
```

### Example 2: Get all entries in all watchlists.
```
Get-SecuronixWatchlistData -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'
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

### -Query
A spotter query to be processed by Securonix. Valid indexes are: activity, violation, users, asset, geolocation, lookup, riskscore, riskscorehistory.

## Links
[Securonix 6.4 REST API Categories - Watchlist ](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Watchlist)