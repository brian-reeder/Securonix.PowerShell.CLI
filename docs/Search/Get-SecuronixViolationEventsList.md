# Get-SecuronixViolationEventsList
Get a list of entries in the violation index.

## Syntax
```
Get-SecuronixViolationEventsList
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
Get-SecuronixViolationEventsList prepares API parameters and queries the Securonix violation index.

## Examples

### Example 1: Get violations for policy "Email sent to self"

Request
```
Get-SecuronixViolationEventsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-TimeStart '08/19/2019 00:00:00' -TimeEnd '08/19/2019 23:59:59' \
-Query 'policyname="Email sent to self"'
```

Response
```
{
    "totalDocuments": 2,
    "events": [{ 
        "timeline_by_month": "1564635600000",
        "u_division": "Credit Products",
        "year": "2019",
        "riskthreatname": "DATA EGRESS VIA EMAIL",
        "u_createdate": "1563508224000",
        "eventtime": "08/19/2019 07:14:55",
        "u_encrypted": "false",
        "u_criticality": "Low",
        "jobid": "212",
        "rg_id": "3",
        "u_id": "96",
        "accountname": "CYNDI.CONVERSE@CST1.COM",
        "emailsubject": "FWD=stuff",
        "generationtime": "08/19/2019 12:04:32",
        "rawevent": "Received=2019-08-19T12:14:55.301Z|SenderAddress=Cyndi.Converse@CST1.com|RecipientAddress=CyndiConverse@gmail.com|Subject= FWD: stuff|Status=Delivered|ToIP=17.172.34.9|FromIP=129.75.15.25|Size=10000|MessageTraceId=5786595c-6365-4314-7a5b-08d7199f0fdf|StartDate=2019-08-05T12:05:11.486Z|EndDate=2019-08-05T12:35:12.104Z|Index=80830|filename=TeslaRoadster_engine_design.pdf",
        "dayofyear": "231",
        "u_lastname": "Converse",
        "u_uniquecode": "1810920578",
        "u_firstname": "Cyndi",
        "filename": "TeslaRoadster_engine_design.pdf",
        "month": "7",
        "u_userid": "-1",
        "invalid": "false",
        "emailrecipient": "CyndiConverse@gmail.com",
        "u_mergeuniquecode": "0",
        "tenantname": "Securonix",
        "policyname": "Email sent to self",
        "resourcename": "Symantec Email DLP",
        "eventid": "812537a3-1812-4108-a59c-878ed5897167",
        "u_employeeid": "1096",
        "u_department": "Credit Evaluation",
        "week": "34",
        "filesize": "10000",
        "dayofmonth": "19",
        "timeline_by_hour": "1566234000000",
        "hour": "7",
        "tenantid": "1",
        "u_status": "1",
        "u_lanid": "CC1096",
        "timeline_by_minute": "1566216600000",
        "rg_name": "Symantec Email DLP",
        "violator": "Activityaccount",
        "u_lastsynctime": "1563508224000",
        "u_title": "Vice President Credit Products",
        "transactionstring1": "Outbound Email",
        "categorizedtime": "Afternoon",
        "jobstarttime": "1566234187000",
        "u_skipencryption": "false",
        "categoryseverity": "0",
        "u_masked": "false",
        "u_fullname": "Cyndi Converse",
        "u_workemail": "Cyndi.Converse@CST1.com",
        "u_riskscore": "0.01",
        "timeline": "1566190800000",
        "dayofweek": "2",
        "timeline_by_week": "1566104400000",
        "category": "DATA EXFILTRATION",
        "u_timezoneoffset": "CST6CDT",
        "u_datasourceid": "10027"
    }]
}
```

### Example 2: Get violations for policy "Email sent to self" using time epoch.

Request
```
Get-SecuronixViolationEventsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-TimeStart '1566190800' -TimeEnd '1566277199' \
-Query 'policyname="Email sent to self"'
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
Required to query the violation index. Enter the event time start range. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS'.

### -TimeEnd
Required to query the violation index. Enter the event time end range. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS'.

### -TimeZone
Enter the timezone info. If empty, the application timezone will be selected.

### -Max
Enter the number of records you want the REST API to return. Default: 1000, Max: 10000.

### -QueryId
Used for paginating through the results in the specified duration to ge the next set of maximum records. When you run the query for the first time, the response has the queryId. You can use the queryId to look for records on a specific page.

## Links
[Securonix 6.4 REST API Categories - Violations](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Violations)