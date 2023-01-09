# Get-SecuronixGeolocationData
Get a list of entries in the geolocation index.

## Syntax
```
Get-SecuronixGeolocationData
    [-Url] <string>
    [-Token] <string>
    [[-Query] <string>]
```

## Description
Get-SecuronixGeolocationData prepares API parameters and queries the Securonix geolocation index. If any events are matched, they will be returned by the API in groups of 1000 if Max is not supplied.

## Examples

### Example 1: Get geolocation entries attributed to Paris, France.
Request
```
Get-SecuronixGeolocationData -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-Query 'location = "City:Paris Region:A8 Country:FR" AND longitude = "2.3488"'
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
                    "key": "ipto",
                    "value": "82.245.175.255"
                },{
                    "key": "city",
                    "value": "Paris"
                },{
                    "key": "ipfrom",
                    "value": "82.245.172.0"
                },{
                    "key": "countrycode",
                    "value": "FR"
                },{
                    "key": "latitude",
                    "value": "48.8534"
                },{
                    "key": "tenantid",
                    "value": "2"
                },{
                    "key": "location",
                    "value": "City:Paris Region:A8 Country:FR"
                },{
                    "key": "tenantname",
                    "value": "partnerdemo"
                },{
                    "key": "source",
                    "value": "MaxMind"
                },{
                    "key": "region",
                    "value": "A8"
                },{
                    "key": "longitude",
                    "value": "2.3488"
                }
            ]
        }
    }]
    "from": "1533838265301",
    "offset": "1000",
    "query": "index=geolocation and location = \"City:Paris Region:A8 Country:FR\" and longitude = \"2.3488\"",
    "searchViolations": "false",
    "to": "1536516665301",
    "totalDocuments": "1"
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

## Links
[Securonix 6.4 REST API Categories - Geolocation](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Geolocation)