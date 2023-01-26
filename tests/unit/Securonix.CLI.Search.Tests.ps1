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

Describe 'Get-SecuronixActivityEvents' {
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
            $response = Get-SecuronixActivityEvents -Url $url -Token $token `
                -TimeStart $timestart_datetime -TimeEnd $timeend_datetime `
                -Query $query -Max 10000
        }
        It 'Given datetime, it returns a list of events.' {
            $response = Get-SecuronixActivityEvents -Url $url -Token $token `
                -TimeStart $timestart_datetime -TimeEnd $timeend_datetime `
                -Query $query
        }
        It 'Given time epoch, it returns a list of events.' {
            $response = Get-SecuronixActivityEvents -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch -Query $query
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixActivityEvents -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch -Query $query `
                -TimeZone 'cst6' -Max 10000 -QueryId '42'
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixActivityEvents $url $token $timestart_datetime `
                $timeend_datetime
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.totalDocuments | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixViolationEvents' {
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
            $response = Get-SecuronixViolationEvents -Url $url -Token $token `
                -TimeStart $timestart_datetime -TimeEnd $timeend_datetime
        }
        It 'Given datetime, it returns a list of events.' {
            $response = Get-SecuronixViolationEvents -Url $url -Token $token `
                -TimeStart $timestart_datetime -TimeEnd $timeend_datetime -Query $query
        }
        It 'Given time epoch, it returns a list of events.' {
            $response = Get-SecuronixViolationEvents -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch -Query $query
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixViolationEvents -Url $url -Token $token `
                -TimeStart $timestart_datetime -TimeEnd $timeend_datetime `
                -Query $query -TimeZone 'cst6' -Max 10000 -QueryId '42'
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixViolationEvents $url $token `
                $timestart_datetime $timeend_datetime
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.totalDocuments | Should -not -BeNullOrEmpty
        }
    }
}

AfterAll {
    Remove-Module Securonix.CLI*
}