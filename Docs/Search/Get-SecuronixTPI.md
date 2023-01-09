# Get-SecuronixTPI
Get a list of entries in the tpi index.

## Syntax
```
Get-SecuronixTPI
    [-Url] <string>
    [-Token] <string>
    [[-Query] <string>]
```

## Description
Get-SecuronixTPI prepares API parameters and queries the Securonix third party intel index.

## Examples

### Example 1: Get entries for malicious domains in the tpi index.

Request
```
Get-SecuronixTPI -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
 -Query 'tpi_type = "Malicious Domain"'
```

Response
```
{
    "available": "true",
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
                    "key": "tpi_domain",
                    "value": "zzzpooeaz-france.com"
                },{
                    "key": "tpi_src",
                    "value": "MalwareDomains"
                },{
                    "key": "tpi_addr",
                    "value": "zzzpooeaz-france.com"
                },{
                    "key": "tpi_category",
                    "value": "phishing"
                },{
                    "key": "tpi_date",
                    "value": "1536185613368"
                },{
                    "key": "tpi_criticality",
                    "value": "1.0"
                },{
                    "key": "tenantid",
                    "value": "2"
                },{
                    "key": "tenantname",
                    "value": "partnerdemo"
                },{
                    "key": "tpi_type",
                    "value": "Malicious Domain"
                }
            ]
        }
    }],
    "from": "1533838946923",
    "offset": "1000",
    "query": "index=tpi and tpi_type = \"Malicious Domain\"",
    "searchViolations": "false",
    "to": "1536517346923",
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
[Securonix 6.4 REST API Categories - Third Party Intel](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#ThirdPartyIntel)