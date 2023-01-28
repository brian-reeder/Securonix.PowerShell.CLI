# Get-SecuronixAssetData
Get a list of entries in the asset index.

## Syntax
```
Get-SecuronixAssetData
    [-Url] <string>
    [-Token] <string>
    [[-Query] <string>]
```

## Description
Get-SecuronixAssetData prepares API parameters and queries the Securonix asset index. If any events are matched, they will be returned by the API in groups of 1000 if Max is not supplied.

## Examples

### Example 1: Get an asset from the asset index.
Request
```
GetSecuronixAssetData -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' \
-Query 'entityname="QUALYYSTEST|30489654_42428"'
```

Response
```
{
    "available": "false",
    "error": "false",
    "events": {
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
                    "key": "key_published_datetime",
                    "value": "2014-03-31T23:11:13Z"
                },{ 
                    "key": "key_type",
                    "value": "Potential"
                },{
                    "key": "key_software.product1",
                    "value": "openssh"
                },{
                    "key": "key_qid",
                    "value": "42428"
                },{
                    "key": "key_ssl",
                    "value": "0"
                },{
                    "key": "key_is_ignored",
                    "value": "0"
                },{
                    "key": "key_category",
                    "value": "General remote services"
                },{
                    "key": "key_severity_level",
                    "value": "2"
                },{
                    "key": "entityname",
                    "value": "QUALYSTEST|30489654_42428"
                },{
                    "key": "key_last_update_datetime",
                    "value": "2017-10-27T21:50:54Z"
                },{
                    "key": "key_discovery.additional_info",
                    "value": "Patch Available"
                },{
                    "key": "key_title",
                    "value": "OpenSSH \"child_set_env()\" Security Bypass Issue"
                },{
                    "key": "key_times_found",
                    "value": "40"
                },{
                    "key": "key_status",
                    "value": "Active"
                },{
                    "key": "key_consequence",
                    "value": "This issue can be exploited by malicious local users to bypass certain security restrictions."
                },{
                    "key": "key_bugtraq.id1",
                    "value": "66355"
                },{
                    "key": "key_vendor_reference.id1",
                    "value": "OpenSSH 6.6"
                },{
                    "key": "key_last_test_datetime",
                    "value": "2017-10-27T21:50:08Z"
                },{
                    "key": "key_ip",
                    "value": "54.174.19.196"
                },{
                    "key": "key_solution",
                    "value": "Upgrade to OpenSSH 6.6 or later to resolve this issue. Refer to <A HREF=\"http://www.openssh.org/txt/release-6.6\" TARGET=\"_blank\">OpenSSH 6.6 Release Notes</A> for further information. <P>Patch:<BR> Following are links for downloading patches to fix the vulnerabilities"
                },{
                    "key": "key_os",
                    "value": "Linux 2.6"
                },{
                    "key": "key_first_found_datetime",
                    "value": "2017-04-06T20:51:41Z"
                },{
                    "key": "key_patchable",
                    "value": "1"
                },{
                    "key": "key_diagnosis",
                    "value": "OpenSSH (OpenBSD Secure Shell) is a set of computer programs providing encrypted communication sessions over a computer network using the SSH protocol.<P> <P> The security issue is caused by an error within the &quot;child_set_env()&quot; function (usr.bin/ssh/session.c) and can be exploited to bypass intended environment restrictions by using a substring before a wildcard character. <P> Affected Versions:<BR> OpenSSH Versions prior to 6.6 are affected"
                },{
                    "key": "key_vendor_reference.url1",
                    "value": "http://www.openssh.com/txt/release-6.6"
                },{
                    "key": "key_software.vendor1",
                    "value": "openbsd"
                },{
                    "key": "key_id",
                    "value": "30489654"
                },{
                    "key": "key_bugtraq.url1", 
                    "value": "http://www.securityfocus.com/bid/66355"
                },{
                    "key": "key_severity",
                    "value": "2"
                },{
                    "key": "key_last_processed_datetime",
                    "value": "2017-10-27T21:50:54Z"
                },{
                    "key": "key_pci_flag",
                    "value": "1"
                },{
                    "key": "key_last_service_modification_datetime",
                    "value": "2015-09-07T03:30:24Z"
                },{
                    "key": "entitytype",
                    "value": "Resources"
                },{
                    "key": "key_results",
                    "value": "SSH-2.0-OpenSSH_6.2 detected on port 22 over TCP."
                },{
                    "key": "key_vuln_type",
                    "value": "Potential Vulnerability"
                },{
                    "key": "key_is_disabled",
                    "value": "0"
                },{
                    "key": "key_last_found_datetime",
                    "value": "2017-10-27T21:50:08Z"
                },{
                    "key": "key_discovery.remote",
                    "value": "1"
                },{
                    "key": "key_cve.id1",
                    "value": "CVE-2014-2532"
                },{
                    "key": "key_cve.url1",
                    "value": "http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-2532"
                }
            ]
        }
    },
    "from": "1533839022549",
    "offset": "1000",
    "query": "index=asset and entityname = \"QUALYSTEST|30489654_42428\"",
    "searchViolations": "false",
    "to": "1536517422549",
    "totalDocuments": "1"
}
```

### Example 2: Get all entries in the Asset Index

Request
```
Get-SecuronixAssetData -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'
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
[Securonix 6.4 REST API Categories - Asset](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Asset)