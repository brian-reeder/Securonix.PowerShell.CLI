# Get-SecuronixUsersData
Get a list of entries in the users index.

## Syntax
```
Get-SecuronixUsersData
    [-Url] <string>
    [-Token] <string>
    [[-Query] <string>]
```

## Description
Get-SecuronixUsersData prepares API parameters and queries the Securonix users index.

## Examples

### Example 1: Get user entries

Request
```
Get-SecuronixUsersData -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-Query 'location = "Dallas" AND lastname = "OGWA"'
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
                    "key": "u_employeeid",
                    "value": "1003"
                },{
                    "key": "u_department",
                    "value": "Mainframe and Midrange Administration"
                },{
                    "key": "u_workphone",
                    "value": "9728151641"
                },{
                    "key": "u_division",
                    "value": "Global Technology"
                },{
                    "key": "u_networkid",
                    "value": "HOGWA"
                },{
                    "key": "u_approveremployeeid",
                    "value": "1082"
                },{
                    "key": "u_mobile",
                    "value": "01689 861334"
                },{
                    "key": "u_jobcode",
                    "value": "R1"
                },{
                    "key": "u_hiredate",
                    "value": "1249707600000"
                },{
                    "key": "u_costcentername",
                    "value": "IINFCCC12"
                },{
                    "key": "u_criticality",
                    "value": "Low"
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
                    "key": "u_managerlastname",
                    "value": "Ogwa"
                },{
                    "key": "u_companynumber",
                    "value": "TECH12"
                },{
                    "key": "u_lanid",
                    "value": "HO1003"
                },{
                    "key": "u_country",
                    "value": "USA"
                },{
                    "key": "u_orgunitnumber",
                    "value": "12"
                },{
                    "key": "u_workemail|1504649718554_u",
                    "value": "HILLARY.OGWA@company.com"
                },{
                    "key": "u_title",
                    "value": "Associate Mainframe Administrator"
                },{
                    "key": "u_companycode",
                    "value": "TECH"
                },{
                    "key": "u_regtempin",
                    "value": "Regular"
                },{
                    "key": "u_lastname",
                    "value": "OGWA"
                },{
                    "key": "u_statusdescription",
                    "value": "Active"
                },{
                    "key": "u_managerfirstname",
                    "value": "Harry"
                },{
                    "key": "u_firstname",
                    "value": "HILLARY"
                },{
                    "key": "u_middlename",
                    "value": "C"
                },{
                    "key": "u_hierarchy",
                    "value": "4"
                },{
                    "key": "u_masked",
                    "value": "false"
                },{
                    "key": "u_employeetype",
                    "value": "FT"
                },{
                    "key": "u_fulltimeparttimein",
                    "value": "FullTime"
                },{
                    "key": "u_workemail",
                    "value": "HILLARY.OGWA@scnx.com"
                },{
                    "key": "u_manageremployeeid",
                    "value": "1001"
                },{
                    "key": "u_riskscore",
                    "value": "0.01"
                },{
                    "key": "u_location",
                    "value": "DALLAS"
                },{
                    "key": "u_costcentercode",
                    "value": "IINFCCC12"
                },{
                    "key": "tenantname",
                    "value": "partnerdemo"
                },{
                    "key": "u_timezoneoffset",
                    "value": "CST"
                }
            ]
        }
    }],
    "from": "1533833149104",
    "offset": "1000",
    "query": "index=users AND location=\"Dallas\" AND lastname=\"OGWA\"",
    "searchViolations": "false",
    "to": "1536511549104", "totalDocuments": "1"
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
[Securonix 6.4 REST API Categories - Users](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Users)