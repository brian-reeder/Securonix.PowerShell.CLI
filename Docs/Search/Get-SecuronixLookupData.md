# Get-SecuronixLookupData
Get a list of entries in the lookup index.

## Syntax
```
Get-SecuronixLookupData
    [-Url] <string>
    [-Token] <string>
    [[-Query] <string>]
```

## Description
Get-SecuronixLookupData prepares API parameters and queries the Securonix lookup index.

## Examples

### Example 1: Get lookup entries in the Vulnerable Hosts lookup table.
Request
```
Get-SecuronixLookupData -Url "DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" \
-Query 'lookupname = "VulnerableHostLookUpTable"'
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
                    "key": "value_u_customfield4",
                    "value": "allows attackers to obtain sensitive information"
                },{
                    "key": "value_u_customfield11",
                    "value": "CVE-2014-2212"
                },{
                    "key": "lookupname",
                    "value": "VulnerableHostLookUpTable"
                },{
                    "key": "key",
                    "value": "WW9452"
                }
            ]
        }
    }],
    "from": "1533838272825",
    "offset": "1000",
    "query": "index=lookup and lookupname = \"VulnerableHostLookUpTable\"",
    "searchViolations": "false",
    "to": "1536516672825",
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
[Securonix 6.4 REST API Categories - Lookup](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Lookup)