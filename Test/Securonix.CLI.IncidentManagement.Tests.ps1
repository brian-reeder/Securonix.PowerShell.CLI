# Invoke-Pester -Output Detailed .\Test\*.Tests.ps1
BeforeAll {
    Remove-Module Securonix.CLI -ErrorAction SilentlyContinue
    Import-Module $PSScriptRoot\..\Securonix.CLI.psd1

    $Url = 'https://dundermifflin.securonix.net/Snypr'

    $IncidentsList = ConvertFrom-Json '{"status": "OK","result": {"data": {"totalIncidents": 1.0,"incidentItems": [{"violatorText": "Cyndi Converse","lastUpdateDate": 1566293234026,"violatorId": "96","incidentType": "RISK MODEL","incidentId": "100181","incidentStatus": "COMPLETED","riskscore": 0.0,"assignedUser": "Account Access 02","assignedGroup": "Administrators","priority": "None","reason": ["Resource: Symantec Email DLP"],"violatorSubText": "1096","entity": "Users","workflowName": "SOCTeamReview","url": "DunderMifflin.securonix.com/Snypr/configurableDashboards/view?&type=incident&id=100181","isWhitelisted": false,"watchlisted": false}]}}}'
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

AfterAll {
    Remove-Module Securonix.CLI
}