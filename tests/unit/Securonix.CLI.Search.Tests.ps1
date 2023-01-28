# Invoke-Pester -Output Detailed .\Test\*.Tests.ps1
[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessage(
    'PSUseDeclaredVarsMoreThanAssignments', '',
    Justification='PSSA does not properly detect for Pester scripts'
)]
Param()

BeforeAll {
    $modulepath = "$PSScriptRoot\..\..\src\Securonix.CLI\Securonix.CLI.psd1"

    Remove-Module Securonix.CLI* -ErrorAction SilentlyContinue
    Import-Module $modulepath

    $url   = 'https://dundermifflin.securonix.net/Snypr'
    $token = '12345678-90AB-CDEF-1234-567890ABCDEF'

    $timestart_datetime = '01/02/2008 00:00:00'
    $timeend_datetime = '01/03/2008 00:00:00'

    $timestart_epoch = '1199253600'
    $timeend_epoch = '1199340000'

}

Describe 'Get-SecuronixActivityEventsList' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"totalDocuments": 69490,"events": [{"timeline_by_month": "1588309200000","rg_timezoneoffset": "Asia/Kolkata","resourcegroupname": "carbonblackalert_19mayRIn","eventid": "bcb2c382-a14f-4673-ae8e-af64901d2d94","ipaddress": "192.168.1.14","week": "21","year": "2020","accountresourcekey": "ROOT~carbonblackalert_19mayRIn~carbonblackalert_19mayRIn~815~-1","resourcehostname": "lm11197","sourceprocessname": "bash","rg_functionality": "umesh","userid": "-1","customfield2": "1589916440853","dayofmonth": "20","jobid": "-5","resourcegroupid": "815","datetime": "1589916504386","timeline_by_hour": "1589914800000","collectiontimestamp": "1589915105445","hour": "0","accountname": "ROOT","tenantid": "54","id": "-1","rg_resourcetypeid": "449","_indexed_at_tdt": "Tue May 19 15:28:30 EDT 2020","timeline_by_minute": "1589916300000","routekey": "54-202005190003","collectionmethod": "carbonblackalerts","receivedtime": "1589916504387","publishedtime": "1589916440853","categorizedtime": "Night","jobstarttime": "1589915105445","dayofyear": "141","minute": "58","categoryseverity": "0","rg_vendor": "umesh","month": "4","_version_": "1667148295203454980","timeline": "1589864400000","dayofweek": "4","timeline_by_week": "1589691600000","tenantname": "CORDALA","resourcename": "carbonblackalert_19mayRIn","ingestionnodeid": "umesh_du-10-0-0-81.securonix.com"}],"error": false,"available": false,"queryId": "spotterwebservicee8904c76-b230-4ad7-990f-eefd220a22b8","applicationTz": "CST6CDT","inputParams": {"eventtime_from": " \"05/19/2020 00:00:00\"","max": "1","query": "index=activity AND resourcegroupname = \"carbonblackalert_19mayRIn\"","eventtime_to": " \"05/19/2020 23:59:59\""},"index": "activity"}'

        $query = 'accountname="admin"'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Search
        }
        It 'Given only required parameters, it returns a list of events.' {
            $response = Get-SecuronixActivityEventsList -Url $url -Token $token `
                -TimeStart $timestart_datetime -TimeEnd $timeend_datetime `
                -Query $query -Max 10000
        }
        It 'Given datetime, it returns a list of events.' {
            $response = Get-SecuronixActivityEventsList -Url $url -Token $token `
                -TimeStart $timestart_datetime -TimeEnd $timeend_datetime `
                -Query $query
        }
        It 'Given time epoch, it returns a list of events.' {
            $response = Get-SecuronixActivityEventsList -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch -Query $query
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixActivityEventsList -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch -Query $query `
                -TimeZone 'cst6' -Max 10000 -QueryId '42'
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixActivityEventsList $url $token $timestart_datetime `
                $timeend_datetime
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixAssetData' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"available": "false","error": "false","events": {"directImport": "false","hour": "0","ignored": "false","invalid": "false","invalidEventAction": "0","tenantid": "1","tenantname": "Securonix","u_id": "-1","u_userid": "-1","result": {"entry": [{"key": "key_published_datetime","value": "2014-03-31T23:11:13Z"},{ "key": "key_type","value": "Potential"},{"key": "key_software.product1","value": "openssh"},{"key": "key_qid","value": "42428"},{"key": "key_ssl","value": "0"},{"key": "key_is_ignored","value": "0"},{"key": "key_category","value": "General remote services"},{"key": "key_severity_level","value": "2"},{"key": "entityname","value": "QUALYSTEST|30489654_42428"},{"key": "key_last_update_datetime","value": "2017-10-27T21:50:54Z"},{"key": "key_discovery.additional_info","value": "Patch Available"},{"key": "key_title","value": "OpenSSH \"child_set_env()\" Security Bypass Issue"},{"key": "key_times_found","value": "40"},{"key": "key_status","value": "Active"},{"key": "key_consequence","value": "This issue can be exploited by malicious local users to bypass certain security restrictions."},{"key": "key_bugtraq.id1","value": "66355"},{"key": "key_vendor_reference.id1","value": "OpenSSH 6.6"},{"key": "key_last_test_datetime","value": "2017-10-27T21:50:08Z"},{"key": "key_ip","value": "54.174.19.196"},{"key": "key_solution","value": "Upgrade to OpenSSH 6.6 or later to resolve this issue. Refer to <A HREF=\"http://www.openssh.org/txt/release-6.6\" TARGET=\"_blank\">OpenSSH 6.6 Release Notes</A> for further information. <P>Patch:<BR> Following are links for downloading patches to fix the vulnerabilities"},{"key": "key_os","value": "Linux 2.6"},{"key": "key_first_found_datetime","value": "2017-04-06T20:51:41Z"},{"key": "key_patchable","value": "1"},{"key": "key_diagnosis","value": "OpenSSH (OpenBSD Secure Shell) is a set of computer programs providing encrypted communication sessions over a computer network using the SSH protocol.<P> <P> The security issue is caused by an error within the &quot;child_set_env()&quot; function (usr.bin/ssh/session.c) and can be exploited to bypass intended environment restrictions by using a substring before a wildcard character. <P> Affected Versions:<BR> OpenSSH Versions prior to 6.6 are affected"},{"key": "key_vendor_reference.url1","value": "http://www.openssh.com/txt/release-6.6"},{"key": "key_software.vendor1","value": "openbsd"},{"key": "key_id","value": "30489654"},{"key": "key_bugtraq.url1", "value": "http://www.securityfocus.com/bid/66355"},{"key": "key_severity","value": "2"},{"key": "key_last_processed_datetime","value": "2017-10-27T21:50:54Z"},{"key": "key_pci_flag","value": "1"},{"key": "key_last_service_modification_datetime","value": "2015-09-07T03:30:24Z"},{"key": "entitytype","value": "Resources"},{"key": "key_results","value": "SSH-2.0-OpenSSH_6.2 detected on port 22 over TCP."},{"key": "key_vuln_type","value": "Potential Vulnerability"},{"key": "key_is_disabled","value": "0"},{"key": "key_last_found_datetime","value": "2017-10-27T21:50:08Z"},{"key": "key_discovery.remote","value": "1"},{"key": "key_cve.id1","value": "CVE-2014-2532"},{"key": "key_cve.url1","value": "http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-2532"}]}},"from": "1533839022549","offset": "1000","query": "index=asset and entityname = \"QUALYSTEST|30489654_42428\"","searchViolations": "false","to": "1536517422549","totalDocuments": "1"}'

        $query = 'entityname="QUALYSTEST|30489654_42428"'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Search
        }
        It 'Given only required parameters, it returns a list of events.' {
            $response = Get-SecuronixAssetData -Url $url -Token $token
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixAssetData -Url $url -Token $token -Query $query
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixAssetData $url $token $query
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixGeolocationData' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"available": "false","error": "false","events": [{"directImport": "false","hour": "0","ignored": "false","invalid": "false","invalidEventAction": "0","tenantid": "1","tenantname": "Securonix","u_id": "-1","u_userid": "-1","result": {"entry": [{"key": "ipto","value": "82.245.175.255"},{"key": "city","value": "Paris"},{"key": "ipfrom","value": "82.245.172.0"},{"key": "countrycode","value": "FR"},{"key": "latitude","value": "48.8534"},{"key": "tenantid","value": "2"},{"key": "location","value": "City:Paris Region:A8 Country:FR"},{"key": "tenantname","value": "partnerdemo"},{"key": "source","value": "MaxMind"},{"key": "region","value": "A8"},{"key": "longitude","value": "2.3488"}]}}],"from": "1533838265301","offset": "1000","query": "index=geolocation and location = \"City:Paris Region:A8 Country:FR\" and longitude = \"2.3488\"","searchViolations": "false","to": "1536516665301","totalDocuments": "1"}'

        $query = 'location="City:Paris Region:A8 Country:FR" and longitude="2.3488"'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Search
        }
        It 'Given only required parameters, it returns a list of events.' {
            $response = Get-SecuronixGeolocationData -Url $url -Token $token
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixGeolocationData -Url $url -Token $token -Query $query
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixGeolocationData $url $token $query
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixLookupData' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"available": "false","error": "false", "events": [{"directImport": "false","hour": "0","ignored": "false","invalid": "false","invalidEventAction": "0","tenantid": "1","tenantname": "Securonix","u_id": "-1","u_userid": "-1","result": { "entry": [{"key": "value_u_customfield4","value": "allows attackers to obtain sensitive information"},{"key": "value_u_customfield11","value": "CVE-2014-2212"},{"key": "lookupname","value": "VulnerableHostLookUpTable"},{"key": "key","value": "WW9452"}]}}],"from": "1533838272825","offset": "1000","query": "index=lookup and lookupname = \"VulnerableHostLookUpTable\"","searchViolations": "false","to": "1536516672825","totalDocuments": "1" }'

        $query = 'lookupname="VulnerableHostLookUpTable"'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Search
        }
        It 'Given only required parameters, it returns a list of events.' {
            $response = Get-SecuronixLookupData -Url $url -Token $token
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixLookupData -Url $url -Token $token -Query $query
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixLookupData $url $token $query
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixRiskHistory' -Skip {
    It 'Tests have not been implemented. See issue #' {
        $null | Should -Not -BeNullOrEmpty
    }
}

Describe 'Get-SecuronixRiskScorecard' -Skip {
    It 'Tests have not been implemented. See issue #' {
        $null | Should -Not -BeNullOrEmpty
    }
}

Describe 'Get-SecuronixTPI' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"available": "true","error": "false","events": [{"directImport": "false","hour": "0","ignored": "false","invalid": "false","invalidEventAction": "0","tenantid": "1","tenantname": "Securonix","u_id": "-1","u_userid": "-1","result": {"entry": [{"key": "tpi_domain","value": "zzzpooeaz-france.com"},{"key": "tpi_src","value": "MalwareDomains"},{"key": "tpi_addr","value": "zzzpooeaz-france.com"},{"key": "tpi_category","value": "phishing"},{"key": "tpi_date","value": "1536185613368"},{"key": "tpi_criticality","value": "1.0"},{"key": "tenantid","value": "2"},{"key": "tenantname","value": "partnerdemo"},{"key": "tpi_type","value": "Malicious Domain"}]}}],"from": "1533838946923","offset": "1000","query": "index=tpi and tpi_type = \"Malicious Domain\"","searchViolations": "false","to": "1536517346923","totalDocuments": "1"}'

        $query = 'tpi_type="Malicious Domain"'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Search
        }
        It 'Given only required parameters, it returns a list of events.' {
            $response = Get-SecuronixTPI -Url $url -Token $token
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixTPI -Url $url -Token $token -Query $query
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixTPI $url $token $query
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixUsersData' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"available": "false","error": "false","events": [{"directImport": "false","hour": "0","ignored": "false","invalid": "false","invalidEventAction": "0","tenantid": "1","tenantname": "Securonix","u_id": "-1","u_userid": "-1","result": {"entry": [{"key": "u_employeeid","value": "1003"},{"key": "u_department","value": "Mainframe and Midrange Administration"},{"key": "u_workphone","value": "9728151641"},{"key": "u_division","value": "Global Technology"},{"key": "u_networkid","value": "HOGWA"},{"key": "u_approveremployeeid","value": "1082"},{"key": "u_mobile","value": "01689 861334"},{"key": "u_jobcode","value": "R1"},{"key": "u_hiredate","value": "1249707600000"},{"key": "u_costcentername","value": "IINFCCC12"},{"key": "u_criticality","value": "Low"},{"key": "u_employeetypedescription","value": "FullTime"},{"key": "tenantid","value": "2"},{"key": "u_status","value": "1"},{"key": "u_managerlastname","value": "Ogwa"},{"key": "u_companynumber","value": "TECH12"},{"key": "u_lanid","value": "HO1003"},{"key": "u_country","value": "USA"},{"key": "u_orgunitnumber","value": "12"},{"key": "u_workemail|1504649718554_u","value": "HILLARY.OGWA@company.com"},{"key": "u_title","value": "Associate Mainframe Administrator"},{"key": "u_companycode","value": "TECH"},{"key": "u_regtempin","value": "Regular"},{"key": "u_lastname","value": "OGWA"},{"key": "u_statusdescription","value": "Active"},{"key": "u_managerfirstname","value": "Harry"},{"key": "u_firstname","value": "HILLARY"},{"key": "u_middlename","value": "C"},{"key": "u_hierarchy","value": "4"},{"key": "u_masked","value": "false"},{"key": "u_employeetype","value": "FT"},{"key": "u_fulltimeparttimein","value": "FullTime"},{"key": "u_workemail","value": "HILLARY.OGWA@scnx.com"},{"key": "u_manageremployeeid","value": "1001"},{"key": "u_riskscore","value": "0.01"},{"key": "u_location","value": "DALLAS"},{"key": "u_costcentercode","value": "IINFCCC12"},{"key": "tenantname","value": "partnerdemo"},{"key": "u_timezoneoffset","value": "CST"}]}}],"from": "1533833149104","offset": "1000","query": "index=users AND location=\"Dallas\" AND lastname=\"OGWA\"","searchViolations": "false","to": "1536511549104", "totalDocuments": "1"}'

        $query = 'location="Dallas" AND lastname="OGWA"'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Search
        }
        It 'Given only required parameters, it returns a list of events.' {
            $response = Get-SecuronixUsersData -Url $url -Token $token
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixUsersData -Url $url -Token $token -Query $query
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixUsersData $url $token $query
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixViolationEventsList' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"totalDocuments": 2,"events": [{ "timeline_by_month": "1564635600000","u_division": "Credit Products","year": "2019","riskthreatname": "DATA EGRESS VIA EMAIL","u_createdate": "1563508224000","eventtime": "08/19/2019 07:14:55","u_encrypted": "false","u_criticality": "Low","jobid": "212","rg_id": "3","u_id": "96","accountname": "CYNDI.CONVERSE@CST1.COM","emailsubject": "FWD=stuff","generationtime": "08/19/2019 12:04:32","rawevent": "Received=2019-08-19T12:14:55.301Z|SenderAddress=Cyndi.Converse@CST1.com|RecipientAddress=CyndiConverse@gmail.com|Subject= FWD: stuff|Status=Delivered|ToIP=17.172.34.9|FromIP=129.75.15.25|Size=10000|MessageTraceId=5786595c-6365-4314-7a5b-08d7199f0fdf|StartDate=2019-08-05T12:05:11.486Z|EndDate=2019-08-05T12:35:12.104Z|Index=80830|filename=TeslaRoadster_engine_design.pdf","dayofyear": "231","u_lastname": "Converse","u_uniquecode": "1810920578","u_firstname": "Cyndi","filename": "TeslaRoadster_engine_design.pdf","month": "7","u_userid": "-1","invalid": "false","emailrecipient": "CyndiConverse@gmail.com","u_mergeuniquecode": "0","tenantname": "Securonix","policyname": "Email sent to self","resourcename": "Symantec Email DLP","eventid": "812537a3-1812-4108-a59c-878ed5897167","u_employeeid": "1096","u_department": "Credit Evaluation","week": "34","filesize": "10000","dayofmonth": "19","timeline_by_hour": "1566234000000","hour": "7","tenantid": "1","u_status": "1","u_lanid": "CC1096","timeline_by_minute": "1566216600000","rg_name": "Symantec Email DLP","violator": "Activityaccount","u_lastsynctime": "1563508224000","u_title": "Vice President Credit Products","transactionstring1": "Outbound Email","categorizedtime": "Afternoon","jobstarttime": "1566234187000","u_skipencryption": "false","categoryseverity": "0","u_masked": "false","u_fullname": "Cyndi Converse","u_workemail": "Cyndi.Converse@CST1.com","u_riskscore": "0.01","timeline": "1566190800000","dayofweek": "2","timeline_by_week": "1566104400000","category": "DATA EXFILTRATION","u_timezoneoffset": "CST6CDT","u_datasourceid": "10027"}]}'

        $query = 'policyname="Email sent to self"'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Search
        }
        It 'Given only required parameters, it returns a list of events.' {
            $response = Get-SecuronixViolationEventsList -Url $url -Token $token `
                -TimeStart $timestart_datetime -TimeEnd $timeend_datetime
        }
        It 'Given datetime, it returns a list of events.' {
            $response = Get-SecuronixViolationEventsList -Url $url -Token $token `
                -TimeStart $timestart_datetime -TimeEnd $timeend_datetime -Query $query
        }
        It 'Given time epoch, it returns a list of events.' {
            $response = Get-SecuronixViolationEventsList -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch -Query $query
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixViolationEventsList -Url $url -Token $token `
                -TimeStart $timestart_datetime -TimeEnd $timeend_datetime `
                -Query $query -TimeZone 'cst6' -Max 10000 -QueryId '42'
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixViolationEventsList $url $token `
                $timestart_datetime $timeend_datetime
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixWatchlistData' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{ "available": "false", "error": "false", "events": [{ "directImport": "false", "hour": "0", "ignored": "false", "invalid": "false", "invalidEventAction": "0", "tenantid": "1", "tenantname": "Securonix", "u_id": "-1", "u_userid": "-1", "result": {"entry": [ {"key": "reason","value": ""},{"key": "expirydate","value": "1540674976881"},{"key": "u_employeeid","value": "1002"},{"key": "u_department", "value": "Mainframe and Midrange Administration" },{"key": "u_workphone","value": "9728351246"},{"key": "u_division","value": "Global Technology"},{"key": "confidencefactor","value": "0.0"},{"key": "entityname","value": "1002"},{"key": "u_jobcode","value": "R1"},{"key": "u_hiredate","value": "1249707600000"},{"key": "type","value": "Users"},{"key": "u_costcentername","value": "IINFCCC12"},{"key": "expired","value": "false"},{"key": "u_employeetypedescription","value": "FullTime"},{"key": "tenantid","value": "2"},{"key": "u_status","value": "1"},{"key": "decayflag","value": "false"},{"key": "u_lanid","value": "HO1002"},{"key": "u_country","value": "USA"},{"key": "u_title","value": "Associate Mainframe Administrator"},{"key": "u_companycode","value": "TECH"},{"key": "watchlistuniquekey","value": "2^~Flight Risk Users|1002"},{"key": "u_lastname","value": "OGWAL"},{"key": "u_statusdescription","value": "Active"},{"key": "u_firstname","value": "HOMER"},{"key": "u_middlename","value": "B"},{"key": "u_masked","value": "false"},{"key": "u_employeetype","value": "FT"},{"key": "watchlistname","value": "Flight Risk Users"},{"key": "u_workemail","value": "HOMER.OGWAL@scnx.com"},{"key": "u_manageremployeeid","value": "1001"},{"key": "tenantname","value": "partnerdemo"},{"key": "u_location","value": "LOS ANGELES"}]}}],"from": "1533842667887", "offset": "1000", "query": "index=watchlist AND watchlistname=\"Flight Risk Users\"", "searchViolations": "false", "to": "1536521067887", "totalDocuments": "1" }'

        $query = 'watchlistname="Flight Risk Users"'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Search
        }
        It 'Given only required parameters, it returns a list of events.' {
            $response = Get-SecuronixWatchlistData -Url $url -Token $token
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixWatchlistData -Url $url -Token $token -Query $query
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixWatchlistData $url $token $query
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

AfterAll {
    Remove-Module Securonix.CLI*
}