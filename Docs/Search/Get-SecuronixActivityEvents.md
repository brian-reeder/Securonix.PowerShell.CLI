# Get-SecuronixActivityEvents
Get a list of entries in the activity index.

## Syntax
```
Get-SecuronixActivityEvents
    [-Url] <string>
    [-Token] <string>
    [-TimeStart] <string>
    [-TimeEnd] <string>
    [[-Query] <string>]
    [-TimeZone <string>]
    [-Max <int>]
    [-QueryId <string>]
```

## Description
Get-SecuronixActivityEvents prepares API parameters and queries the Securonix activity index. If any events are matched, they will be returned by the API in groups of 1000 if Max is not supplied.

## Examples

### Example 1: Get events for the admin user.
Request
```
Get-SecuronixActivityEvents -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-TimeStart '01/02/2008 00:00:00' -TimeEnd '01/03/2008 00:00:00' \
-Query 'accountname="admin"' -Max 10000
```

Response
```
{
    "totalDocuments": 69490,
    "events": [{
        "timeline_by_month": "1588309200000",
        "rg_timezoneoffset": "Asia/Kolkata",
        "resourcegroupname": "carbonblackalert_19mayRIn",
        "eventid": "bcb2c382-a14f-4673-ae8e-af64901d2d94",
        "ipaddress": "192.168.1.14",
        "week": "21",
        "year": "2020",
        "accountresourcekey": "ROOT~carbonblackalert_19mayRIn~carbonblackalert_19mayRIn~815~-1",
        "resourcehostname": "lm11197",
        "sourceprocessname": "bash",
        "rg_functionality": "umesh",
        "userid": "-1",
        "customfield2": "1589916440853",
        "dayofmonth": "20",
        "jobid": "-5",
        "resourcegroupid": "815",
        "datetime": "1589916504386",
        "timeline_by_hour": "1589914800000",
        "collectiontimestamp": "1589915105445",
        "hour": "0",
        "accountname": "ROOT",
        "tenantid": "54",
        "id": "-1",
        "rg_resourcetypeid": "449",
        "_indexed_at_tdt": "Tue May 19 15:28:30 EDT 2020",
        "timeline_by_minute": "1589916300000",
        "routekey": "54-202005190003",
        "collectionmethod": "carbonblackalerts",
        "receivedtime": "1589916504387",
        "publishedtime": "1589916440853",
        "categorizedtime": "Night",
        "jobstarttime": "1589915105445",
        "dayofyear": "141",
        "minute": "58",
        "categoryseverity": "0",
        "rg_vendor": "umesh",
        "month": "4",
        "_version_": "1667148295203454980",
        "timeline": "1589864400000",
        "dayofweek": "4",
        "timeline_by_week": "1589691600000",
        "tenantname": "CORDALA",
        "resourcename": "carbonblackalert_19mayRIn",
        "ingestionnodeid": "umesh_du-10-0-0-81.securonix.com"
        }],
        "error": false,
        "available": false,
        "queryId": "spotterwebservicee8904c76-b230-4ad7-990f-eefd220a22b8",
        "applicationTz": "CST6CDT",
        "inputParams": {
        "eventtime_from": " \"05/19/2020 00:00:00\"",
        "max": "1",
        "query": "index=activity AND resourcegroupname = \"carbonblackalert_19mayRIn\"",
        "eventtime_to": " \"05/19/2020 23:59:59\""
    },
    "index": "activity"
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

### -Query
A spotter query to be processed by Securonix. Valid indexes are: activity, violation, users, asset, geolocation, lookup, riskscore, riskscorehistory.

### -TimeStart
Required to query the activity index. Enter the event time start range. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS'.

### -TimeEnd
Required to query the activity index. Enter the event time start range. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS'.

### -TimeZone
Enter the timezone info. If empty, the application timezone will be selected.

### -Max
Enter the number of records you want the REST API to return. Default: 1000, Max: 10000.

### -QueryId
Used for paginating through the results in the specified duration to ge the next set of maximum records. When you run the query for the first time, the response has the queryId. You can use the queryId to look for records on a specific page.

## Links
[Securonix 6.4 REST API Categories - Activity](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Activity)