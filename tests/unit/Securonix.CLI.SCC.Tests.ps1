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

    $url        = 'https://dundermifflin.securonix.net/Snypr'
    $token      = '12345678-90AB-CDEF-1234-567890ABCDEF'

    $tenant = 'PA-Scranton'

    $timestart_epoch = '1566249473000'
    $timeend_epoch   = '1568945873000'

    $timestart_date = '08/19/19 21:17:53'
    $timeend_date   = '09/19/19 21:17:53'

    $violatorName = 'dshrute'
    $documentid   = '2^~A^~7|NULL|AW2385^~C^~1^~EP^~66)'
}

Describe 'Get-SecuronixThreats' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"Response": {"Total records": 863778,"offset": 0,"max": 1000,"threats": [{"tenantid": 2,"tenantname": "a1t1said","violator": "RTActivityAccount","entityid": "TESTUSER-FEB 01 01:26:12-33593400","resourcegroupname": "RG_TestA","threatname": "Test_ThreatModel","category": "ALERT","resourcename": "TEST-HOST-QALAB.LOCAL","resourcetype": "RT_TestA","generationtime": "Tue, 1 Feb 2022 @ 02:06:23 AM","generationtime_epoch": 1643702783965,"policies": ["Test_IEE_ActivityAccount","Test_IEE_NetworkAddress"]}]}}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.SCC
        }
        It 'Given required parameters, it returns a list of threats.' {
            $response = Get-SecuronixThreats -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch `
                -TenantName $tenant
        }
        It 'Given datetime parameters, it returns a list of threats.' {
            $response = Get-SecuronixThreats -Url $url -Token $token `
                -TimeStart $timestart_date -TimeEnd $timeend_date `
                -TenantName $tenant
        }
        It 'Given optional parameters, it returns a list of threats.' {
            $response = Get-SecuronixThreats -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch -Offset 1 `
                -Max 2 -TenantName $tenant
        }
        It 'Given positional parameters, it returns a list of threats.' {
            $response = Get-SecuronixThreats $url $token $timestart_epoch `
                $timeend_epoch 1 2 $tenant
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixEntityThreatDetails' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"Response": {"Total records": 1,"threats": [{"tenantid": 2,"tenantname": "India","violator": "Activityaccount","entityid": "AW2385","resourcegroupname": "ADEventDataSecond28Oct2020","threatname": "TM - Catch all activity accounts on 2nd AD Data set 28 Oct 2020","category": "ALERT","resourcename": "ADEVENTDATASECOND28OCT2020","generationtime": "Wed, 28 Oct 2020 @ 07:25:40 AM","generationtime_epoch": 1603887940344,"policies": ["Test_IEE_ActivityAccount","Test_IEE_NetworkAddress"]}]}}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.SCC
        }
        It 'Given required parameters, it returns a list of threats.' {
            $response = Get-SecuronixEntityThreatDetails -Url $url -Token $token `
                -DocumentId $documentid -TenantName $tenant
        }
        It 'Given positional parameters, it returns a list of threats.' {
            $response = Get-SecuronixEntityThreatDetails $url $token $documentid `
                $tenant
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixTopThreats' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{ "Response": { "Date range": ["Jun 11, 2018 11:18:09 AM", "Sep 9, 2018 11:18:09 AM" ], "Total records": 8,"Docs": [{"Threat model id": 118,"Threat nodel name": "Patient Data Compromise", "Description": "No of Stages: 4, Risk Scoring Scheme:STATIC, Weight:100.0","Criticality": "Low","No of violator": 1,"Generation time": 1532388410500},{ "Threat model id": 194, "Threat nodel name": "Privileged IT User-Sabotage","Description": "No of Stages: 4, Risk Scoring Scheme:STATIC, Weight:100.0", "Criticality": "Medium","No of violator": 1,"Generation time": 1532372629487}]}}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.SCC
        }
        It 'Given required parameters for hours, it returns a list of threats.' {
            $response = Get-SecuronixTopThreats -Url $url -Token $token `
                -Hours 1260
        }
        It 'Given required parameters for days, it returns a list of threats.' {
            $response = Get-SecuronixTopThreats -Url $url -Token $token `
                -Days 30
        }
        It 'Given optional parameters for hours, it returns a list of threats.' {
            $response = Get-SecuronixTopThreats -Url $url -Token $token `
                -Hours 1260 -Offset 1 -Max 2
        }
        It 'Given optional parameters for days, it returns a list of threats.' {
            $response = Get-SecuronixTopThreats -Url $url -Token $token `
                -Days 30 -Offset 1 -Max 2
        }
        It 'Given positional parameters, it returns a list of threats.' {
            $response = Get-SecuronixTopThreats $url $token  -Days 1
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixTopViolations' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{ "Response": { "Date range": [ "Jun 11, 2018 11:25:55 AM", "Sep 9, 2018 11:25:55 AM" ],"Total records": 38,"Docs": [{"Policy id": 9237, "Policy name": "Email to Competitor Domain", "Criticality": "Medium", "Violation entity": "Activityaccount", "Policy category": "ALERT", "Threat indicator": "Email to Competitor Domain", "Generation time": 1533250072115, "No of violator": 14, "Description": "Email to Competitor Domain" },{"Policy id": 9236, "Policy name": "Abnormal number of emails sent to external domain as compared to peer members", "Criticality": "Low", "Violation entity": "Activityaccount", "Policy category": "ALERT", "Threat indicator": "Abnormal number of emails sent to external domain as compared to peer members", "Generation time": 1533171483400, "No of violator": 1, "Description": "Abnormal number of emails sent to external domain as compared to peer members" }]}}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.SCC
        }
        It 'Given required parameters for hours, it returns a list of violations.' {
            $response = Get-SecuronixTopViolations -Url $url -Token $token `
                -Hours 1260
        }
        It 'Given required parameters for days, it returns a list of violations.' {
            $response = Get-SecuronixTopViolations -Url $url -Token $token `
                -Days 30
        }
        It 'Given optional parameters for hours, it returns a list of violations.' {
            $response = Get-SecuronixTopViolations -Url $url -Token $token `
                -Hours 1260 -Offset 1 -Max 2
        }
        It 'Given optional parameters for days, it returns a list of violations.' {
            $response = Get-SecuronixTopViolations -Url $url -Token $token `
                -Days 30 -Offset 1 -Max 2
        }
        It 'Given positional parameters, it returns a list of violations.' {
            $response = Get-SecuronixTopViolations $url $token  -Days 1
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixTopViolators' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{ "Response": { "Date range": [ "Jun 11, 2018 11:28:44 AM", "Sep 9, 2018 11:28:44 AM" ], "Total records": 10, "Docs": [ { "Name": "212274BB375846F85252DBD2CCBE7AE4 8E2657AD25B3904CCC449C202598B9B0 ", "Violator entity": "Users", "Risk score": 202.4, "Generation time": 1529035574167, "Department": "E2DE4125FB3335921E1CC05ED00C504A1E0BBBA898C335B9BA10B29F657B9401\t"},{ "Name": "ACF8393CF33B5115506E12D9520EDD15 0CC721E95079DA18955B82AA67F5A4F9 ", "Violator entity": "Users", "Risk score": 140.48, "Generation time": 1532053492068, "Department": "6A2B422B8F594566BA327664B83594383D1FDE1BF5ED4FC39165D247B21CBF50\t"},]} }'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.SCC
        }
        It 'Given required parameters for hours, it returns a list of violations.' {
            $response = Get-SecuronixTopViolators -Url $url -Token $token `
                -Hours 1260
        }
        It 'Given required parameters for days, it returns a list of violations.' {
            $response = Get-SecuronixTopViolators -Url $url -Token $token `
                -Days 30
        }
        It 'Given optional parameters for hours, it returns a list of violations.' {
            $response = Get-SecuronixTopViolators -Url $url -Token $token `
                -Hours 1260 -Offset 1 -Max 2
        }
        It 'Given optional parameters for days, it returns a list of violations.' {
            $response = Get-SecuronixTopViolators -Url $url -Token $token `
                -Days 30 -Offset 1 -Max 2 -Name $violatorName
        }
        It 'Given positional parameters, it returns a list of violations.' {
            $response = Get-SecuronixTopViolators $url $token  -Days 1
        }
        AfterEach {
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

AfterAll {
    Remove-Module Securonix.CLI
}