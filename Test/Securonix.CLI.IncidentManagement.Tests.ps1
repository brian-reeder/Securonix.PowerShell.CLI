# Invoke-Pester -Output Detailed .\Test\*.Tests.ps1
BeforeAll {
    Remove-Module Securonix.CLI -ErrorAction SilentlyContinue
    Import-Module $PSScriptRoot\..\Securonix.CLI.psd1

    $Url = 'https://dundermifflin.securonix.net/Snypr'

    $IncidentsList          = ConvertFrom-Json '{"status": "OK","result": {"data": {"totalIncidents": 1.0,"incidentItems": [{"violatorText": "Cyndi Converse","lastUpdateDate": 1566293234026,"violatorId": "96","incidentType": "RISK MODEL","incidentId": "100181","incidentStatus": "COMPLETED","riskscore": 0.0,"assignedUser": "Account Access 02","assignedGroup": "Administrators","priority": "None","reason": ["Resource: Symantec Email DLP"],"violatorSubText": "1096","entity": "Users","workflowName": "SOCTeamReview","url": "DunderMifflin.securonix.com/Snypr/configurableDashboards/view?&type=incident&id=100181","isWhitelisted": false,"watchlisted": false}]}}}'
    $IncidentActions        = ConvertFrom-Json '{"status": "OK","messages": ["test Message 04"],"result": ["Mark as concern and create incident","Non-Concern","Mark in progress (still investigating)"]}'
    $ActionResponse         = ConvertFrom-Json '{"status": "OK","result": "submitted"}'
    $CommentResponse        = ConvertFrom-Json '{"status": "OK","messages": ["Add comment to incident id - [100289]"],"result": true}'
    $CriticalityResponse    = ConvertFrom-Json '{"status": "OK","messages": ["Criticality updated for incidents : [1727657,172992]"]}'
    $NewIncidentResponse    = ConvertFrom-Json '{"status": "OK","messages":["Get incident details for incident ID [100317]"],"result": {"data": {"totalIncidents": 1.0,"incidentItems": [{"violatorText": "134.119.189.29","lastUpdateDate": 1566337840264,"violatorId": "134.119.189.29","incidentType": "Policy","incidentId": "100317","incidentStatus": "Open","riskscore": 3.0,"assignedUser": "Admin Admin","priority": "low","reason": ["Policy: Repeated Visits to Potentially Malicious address","Threat: Possible C2 Communication"],"entity": "Activityip","workflowName": "SOCTeamReview","url": "https://saaspocapp2t14wptp.securonix.net/Snypr/configurableDashboards/view?&type=incident&id=100317","isWhitelisted": false,"watchlisted": false}]}}}'
    $ViolationScoreResponse = ConvertFrom-Json '{"status": "OK","messages": ["Violation score updated for AA01MAC, Policyname:All Resources - AD04Dataset - 09 Nov 2020 by 5.0 from SOAR API"],"result": []}'
}

Describe 'Get-SecuronixIncidentsList' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $IncidentsList } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given only required parameters, it returns a list of incidents.' {
            $response = Get-SecuronixIncidentsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -TimeStart '1566249473000' -TimeEnd '1566335873000' -RangeType 'updated'
            Should -InvokeVerifiable
            $response.totalIncidents | Should -not -BeNullOrEmpty
        }
        It 'Given datetime, it returns a list of events.' {
            $response = Get-SecuronixIncidentsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -TimeStart '08/19/19 21:17:53' -TimeEnd '08/20/19 21:17:53' -RangeType 'updated'
            Should -InvokeVerifiable
            $response.totalIncidents | Should -not -BeNullOrEmpty
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixIncidentsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -TimeStart '1566249473000' -TimeEnd '1566335873000' -RangeType 'updated' -Status 'Claimed' -AllowChildCases -Max 10000 -Offset '42'
            Should -InvokeVerifiable
            $response.totalIncidents | Should -not -BeNullOrEmpty
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixIncidentsList 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' '1566249473000' '1566335873000' 'updated'
            Should -InvokeVerifiable
            $response.totalIncidents | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixThreatActions' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $IncidentActions } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given the required parameters, it returns a list of actions.' {
            $response = Get-SecuronixThreatActions -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Update-SecuronixIncident' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ActionResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given the required parameters, it returns a confirmation.' {
            $response = Update-SecuronixIncident -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '10029' -ActionName 'comment' -Attributes @{'comment'='comment message';'username'='jhalpert';'firstname'='Jim';'lastname'='Halpert'}
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
    }
}

Describe 'Add-SecuronixComment' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $CommentResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given the required parameters, it returns a confirmation.' {
            $response = Add-SecuronixComment -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '10029' -Comment 'This is a test'
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
        It 'Given optional parameters, it returns a confirmation.' {
            $response = Add-SecuronixComment -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '10029' -Comment 'This is a test' -Username 'jhalpert' -Firstname 'Jim' -Lastname 'Halpert'
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
        It 'Given positional parameters, it returns a confirmation.' {
            $response = Add-SecuronixComment 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' '10029' 'This is a test'
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
    }
}

Describe 'Update-SecuronixCriticality' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $CriticalityResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given the required parameters, it returns a confirmation.' {
            $response = Update-SecuronixCriticality -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '10029' -Criticality 'low'
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
        It 'Given positional parameters, it returns a confirmation.' {
            $response = Update-SecuronixCriticality 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' '10029' 'low'
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
    }
}

Describe 'New-SecuronixIncident' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $NewIncidentResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given the required parameters, it returns a confirmation.' {
            $response = New-SecuronixIncident -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -ViolationName 'Repeated Visits to Potentially Malicious address' -DatasourceName 'Websense Proxy' -EntityType 'Activityip' -EntityName '134.119.189.29' -Workflow 'SOCTeamReview'
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
        It 'Given positional parameters, it returns a confirmation.' {
            $response = New-SecuronixIncident 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' 'Repeated Visits to Potentially Malicious address' 'Websense Proxy' 'Activityip' '134.119.189.29' 'SOCTeamReview'
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
    }
}

Describe 'Add-SecuronixViolationScore' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ViolationScoreResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given the required parameters, it returns a confirmation.' {
            $response = Add-SecuronixViolationScore -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -ScoreIncrement 1 -TenantName 'Automationtenant' -ViolationName 'policy' -PolicyCategory 'category' -EntityType 'Users' -EntityName 'xyz' -ResourceGroupname 'rgGroup' -ResourceName 'resource'
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
        It 'Given positional parameters, it returns a confirmation.' {
            $response = Add-SecuronixViolationScore 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' 1 'Automationtenant' 'policy' 'category' 'Users' 'xyz' 'rgGroup' 'resource'
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
    }
}

AfterAll {
    Remove-Module Securonix.CLI
}