# Invoke-Pester -Output Detailed .\Test\*.Tests.ps1
BeforeAll {
    Remove-Module Securonix.CLI -ErrorAction SilentlyContinue
    Import-Module $PSScriptRoot\..\Securonix.CLI.psd1

    $url        = 'https://dundermifflin.securonix.net/Snypr'
    $token      = '12345678-90AB-CDEF-1234-567890ABCDEF'
    $IncidentId = '100107'
}

Describe 'Get-SecuronixIncident' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Get incident details for incident ID [100107]"],"result": {"data": {"totalIncidents": 1.0,"incidentItems": [{"violatorText": "Cyndi Converse","lastUpdateDate": 1566232568502,"violatorId": "96","incidentType": "Policy","incidentId": "100107","incidentStatus": "COMPLETED","riskscore": 0.0,"assignedUser": "Admin Admin","priority": "low","reason": ["Resource: Symantec Email DLP","Policy: Emails with large File attachments","Threat: Data egress attempts"],"violatorSubText": "1096","entity": "Users","workflowName": "SOCTeamReview","url": "DunderMifflin.securonix.com/Snypr/configurableDashboards/view?&type=incident&id=100107","isWhitelisted": false,"watchlisted": false}]}}}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the incident details.' {
            $response = Get-SecuronixIncident -Url $url -Token $token `
                -IncidentId $IncidentId
        }
        It 'Given positional parameters, it returns the incident details.' {
            $response = Get-SecuronixIncident $url $token $IncidentId
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.incidentId | Should -be $IncidentId
        }
    }
}

Describe 'Get-SecuronixIncidentStatus' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Get incident status for incident ID [100107] - [COMPLETED]"],"result": {"status": "COMPLETED"}}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the incident status.' {
            $response = Get-SecuronixIncidentStatus -Url $url -Token $token `
                -IncidentId $IncidentId
        }
        It 'Given positional parameters, it returns the incident status.' {
            $response = Get-SecuronixIncidentStatus $url $token $IncidentId
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -be 'COMPLETED'
        }
    }
}

Describe 'Get-SecuronixIncidentWorkflowName' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Get incident workflow for incident ID [100107] - [SOCTeamReview]"],"result": {"workflow": "SOCTeamReview"}}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the incident workflow name.' {
            $response = Get-SecuronixIncidentWorkflowName -Url $url -Token $token `
                -IncidentId $IncidentId
        }
        It 'Given positional parameters, it returns the incident workflow name.' {
            $response = Get-SecuronixIncidentWorkflowName $url $token $IncidentId
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -Be 'SOCTeamReview'
        }
    }
}

Describe 'Get-SecuronixIncidentActions' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Get possible actions for incident ID [100289], incident status [Open]"],"result": [{"actionDetails": [{"title": "Screen1","sections": {"sectionName": "Comments","attributes": [{"displayName": "Comments","attributeType": "textarea","attribute": "15_Comments","required": false}]}}],"actionName": "CLAIM","status": "CLAIMED"},{"actionDetails": [{"title": "Screen1","sections": {"sectionName": "Comments","attributes": [{"displayName": "Business Response","attributeType": "dropdown","values": ["Inaccurate alert-User not a HPA","Inaccurate alert-inaccurate log data","Inaccurate alert-host does not belong to our business","Need more information","Duplicate alert"],"attribute": "10_Business-Response","required": false},{"displayName": "Business Justification","attributeType": "text","attribute": "11_Business-Justification","required": false},{"displayName": "Remediation Performed","attributeType": "text","attribute": "12_Remediation-Performed","required": false},{"displayName": "Business Internal Use","attributeType": "text","attribute": "13_Business-Internal-Use","required": false},{"displayName": "Assign To Analyst","attributeType": "assignto","values": [{"key": "GROUP","value": "Administrators"},{"key": "GROUP","value": "SECURITYOPERATIONS"},{"key": "USER","value": "admin"},{"key": "USER","value": "auditor"},{"key": "USER","value": "useradmin"},{"key": "USER","value": "accessscanner"},{"key": "USER","value": "account08"},{"key": "USER","value": "account10"},{"key": "USER","value": "account06"},{"key": "USER","value": "account07"},{"key": "USER","value": "account02"},{"key": "USER","value": "account09"},{"key": "USER","value": "account01"},{"key": "USER","value": "account05"},{"key": "USER","value": "account03"},{"key": "USER","value": "account04"}],"attribute": "assigntouserid","required": true}]}}],"actionName": "ASSIGN TO ANALYST","status": "OPEN"},{"actionDetails": [{"title": "Screen1","sections": {"sectionName": "Comments","attributes": [{"displayName": "Comments","attributeType": "textarea","attribute": "15_Comments","required": false}]}}],"actionName": "ASSIGN TO SECOPS","status": "OPEN"}]}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the list of actions.' {
            $response = Get-SecuronixIncidentActions -Url $url -Token $token `
                -IncidentId $IncidentId
        }
        It 'Given positional parameters, it returns the list of actions.' {
            $response = Get-SecuronixIncidentActions $url $token $IncidentId
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.actionDetails | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Confirm-SecuronixIncidentAction' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Check if action is possible and get list of parameters - Incident Id - [100289], action Name - [CLAIM], - status - [Open]"],"result": [{"actionDetails": [{"title": "Screen1","sections": {"sectionName": "Comments","attributes": [{"displayName": "Comments","attributeType": "textarea","attribute": "15_Comments","required": false}]}}],"actionName": "CLAIM","status": "CLAIMED"}]}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the action details.' {
            $response = Confirm-SecuronixIncidentAction -Url $url -Token $token `
                -IncidentId $IncidentId -ActionName 'Claim'
        }
        It 'Given positional parameters, it returns the action details.' {
            $response = Confirm-SecuronixIncidentAction $url $token $IncidentId 'Claim'
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.actionDetails | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixWorkflowsList' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Get all possible workflows"],"result": {"workflows": [{"workflow": "SOCTeamReview","type": "USER","value": "admin"},{"workflow": "ActivityOutlierWorkflow","type": "USER","value": "admin"},{"workflow": "AccessCertificationWorkflow","type": "USER","value": "admin"}]}}'
    }
    Context "When token is valid" {
        BeforeAll {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the list of workflows.' {
            $response = Get-SecuronixWorkflowsList -Url $url -Token $token
        }
        It 'Given positional parameters, it returns the list of workflows.' {
            $response = Get-SecuronixWorkflowsList $url $token
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.GetType().BaseType | Should -Be 'Array'
        }
    }
}

Describe 'Get-SecuronixWorkflowDetails' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Workflow Details"],"result": {"SOCTeamReview": {"CLAIMED": [{"Status": "OPEN","Action": "ASSIGN TO ANALYST"},{"Status": "COMPLETED","Action": "ACCEPT RISK"},{"Status": "OPEN","Action": "RELEASE"},{"Status": "CLOSED","Action": "VIOLATION"},{"Status": "OPEN","Action": "ASSIGN TO SECOPS"}],"CLOSED": [{"Status": "PENDING VERIFICATION","Action": "CLAIM"},{"Status": "OPEN","Action": "ASSIGN TO ANALYST"},{"Status": "OPEN","Action": "RELEASE"}],"PENDING VERIFICATION": [{"Status": "COMPLETED","Action": "VERIFY"}],"OPEN": [{"Status": "OPEN","Action": "ASSIGN TO ANALYST"},{"Status": "CLAIMED","Action": "CLAIM"},{"Status": "OPEN","Action": "ASSIGN TO SECOPS"},{"Status": "Do Not Change","Action": "WhiteList_Action"}]}}}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the workflow details.' {
            $response = Get-SecuronixWorkflowDetails -Url $url -Token $token `
                -WorkflowName 'SOCTeamReview'
        }
        It 'Given positional parameters, it returns the workflow details.' {
            $response = Get-SecuronixWorkflowDetails $url $token 'SOCTeamReview'
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.SOCTeamReview | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixWorkflowDefaultAssignee' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Default assignee for workflow [SOCTeamReview] - [admin]"],"result": {"type": "USER","value": "admin"}}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the default assignee.' {
            $response = Get-SecuronixWorkflowDefaultAssignee -Url $url `
                -Token $token -WorkflowName 'SOCTeamReview'
        }
        It 'Given positional parameters, it returns the default assignee.' {
            $response = Get-SecuronixWorkflowDefaultAssignee $url $token 'SOCTeamReview'
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixIncidentsList' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","result": {"data": {"totalIncidents": 1.0,"incidentItems": [{"violatorText": "Cyndi Converse","lastUpdateDate": 1566293234026,"violatorId": "96","incidentType": "RISK MODEL","incidentId": "100181","incidentStatus": "COMPLETED","riskscore": 0.0,"assignedUser": "Account Access 02","assignedGroup": "Administrators","priority": "None","reason": ["Resource: Symantec Email DLP"],"violatorSubText": "1096","entity": "Users","workflowName": "SOCTeamReview","url": "DunderMifflin.securonix.com/Snypr/configurableDashboards/view?&type=incident&id=100181","isWhitelisted": false,"watchlisted": false}]}}}'
    }
    Context "When token is valid" {
        BeforeAll {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given only required parameters, it returns a list of incidents.' {
            $response = Get-SecuronixIncidentsList -Url $url `
                -Token $token -TimeStart '1566249473000' `
                -TimeEnd '1566335873000' -RangeType 'updated'
        }
        It 'Given datetime, it returns a list of events.' {
            $response = Get-SecuronixIncidentsList -Url $url `
                -Token $token -TimeStart '08/19/19 21:17:53' `
                -TimeEnd '08/20/19 21:17:53' -RangeType 'updated'
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixIncidentsList -Url $url `
                -Token $token -TimeStart '1566249473000' `
                -TimeEnd '1566335873000' -RangeType 'updated' `
                -Status 'Claimed' -AllowChildCases -Max 1 -Offset 0
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixIncidentsList $url $token `
                '1566249473000' '1566335873000' 'updated'
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.Count | Should -Be 1
        }
    }
}


# TODO: Set $IncidentAttachmentList
Describe 'Get-SecuronixIncidentAttachments' -Skip {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json ''
        $id = '20019'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns a list of incident attachments.' {
            $response = Get-SecuronixIncidentAttachments -Url $url -Token $token -IncidentId $id
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
        It 'Given time (epoch) parameters, it returns a list of incident attachments.' {
            $response = Get-SecuronixIncidentAttachments -Url $url -Token $token -IncidentId $id -TimeStart '1672617600' -TimeEnd '1672703999'
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
        It 'Given time (datetime) parameters, it returns a list of incident attachments.' {
            $response = Get-SecuronixIncidentAttachments -Whatif-Url $url -Token $token -IncidentId $id -TimeStart '01/02/2023 00:00:00-0' -TimeEnd '01/02/2023 23:59:59-0'
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
        It 'Given positional parameters, it returns a list of incident attachments.' {
            $response = Get-SecuronixIncidentAttachments $url $token $id
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
        It 'Given optional parameters, it returns a list of incident attachments.' {
            $response = Get-SecuronixIncidentAttachments -Url $url -Token $token -IncidentId $id -AttachmentType 'csv'
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixChildIncidents' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Get child case details for incident ID [20019]"],"result": ["20046","20073","20100","20127","20154","20181","20208","20235"]}'
        $id = '20019'
    }
    Context "When token is valid" {
        BeforeAll {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns a list of incident ids.' {
            $response = Get-SecuronixChildIncidents -Url $url -Token $token `
                -IncidentId $id
        }
        It 'Given positional parameters, it returns a list of incident ids.' {
            $response = Get-SecuronixChildIncidents $url $token $id
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -BeGreaterThan 2
        }
    }
}

Describe 'Get-SecuronixIncidentActivityHistory' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Get activity stream details for incident ID [20019]"],"result": {"activityStreamData": [{"caseid": "20019","actiontaken": "CREATED","status": "Open","comment": [],"eventTime": "Jan 21, 2020 2:33:37 AM","username": "Admin Admin","currentassignee": "admin","commentType": [],"currWorkflow": "SOCTeamReview"}]}}'
        $id = '20019'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the activity stream details.' {
            $response = Get-SecuronixIncidentActivityHistory -Url $url -Token $token `
                -IncidentId $id
        }
        It 'Given positional parameters, it returns the activity stream details.' {
            $response = Get-SecuronixIncidentActivityHistory $url $token $id
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.caseid | Should -Be $id
        }
    }
}

Describe 'Get-SecuronixThreatActions' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["test Message 04"],"result": ["Mark as concern and create incident","Non-Concern","Mark in progress (still investigating)"]}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given the required parameters, it returns a list of actions.' {
            $response = Get-SecuronixThreatActions -Url $url -Token $token
        }
        It 'Given the positional parameters, it returns a list of actions.' {
            $response = Get-SecuronixThreatActions $url $token
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.count | Should -BeGreaterThan 0
        }
    }
}

Describe 'Update-SecuronixIncident' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","result": "submitted"}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given the required parameters, it returns a confirmation.' {
            $response = Update-SecuronixIncident -Url $url -Token $token `
                -IncidentId '10029' -ActionName 'comment' `
                -Attributes @{
                    'comment'='comment message';
                    'username'='jhalpert';
                    'firstname'='Jim';
                    'lastname'='Halpert'
                }
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
    }
}

Describe 'Add-SecuronixComment' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Add comment to incident id - [100289]"],"result": true}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given the required parameters, it returns a confirmation.' {
            $response = Add-SecuronixComment -Url $url -Token $token `
                -IncidentId '10029' -Comment 'This is a test'
        }
        It 'Given optional parameters, it returns a confirmation.' {
            $response = Add-SecuronixComment -Url $url -Token $token `
                -IncidentId '10029' -Comment 'This is a test' -Username 'jhalpert' `
                -Firstname 'Jim' -Lastname 'Halpert'
        }
        It 'Given positional parameters, it returns a confirmation.' {
            $response = Add-SecuronixComment $url $token '10029' 'This is a test'
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
    }
}

Describe 'Update-SecuronixCriticality' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Criticality updated for incidents : [1727657,172992]"]}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given the required parameters, it returns a confirmation.' {
            $response = Update-SecuronixCriticality -Url $url -Token $token `
                -IncidentId '10029' -Criticality 'low'
        }
        It 'Given positional parameters, it returns a confirmation.' {
            $response = Update-SecuronixCriticality $url $token '10029' 'low'
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
    }
}

Describe 'New-SecuronixIncident' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages":["Get incident details for incident ID [100317]"],"result": {"data": {"totalIncidents": 1.0,"incidentItems": [{"violatorText": "134.119.189.29","lastUpdateDate": 1566337840264,"violatorId": "134.119.189.29","incidentType": "Policy","incidentId": "100317","incidentStatus": "Open","riskscore": 3.0,"assignedUser": "Admin Admin","priority": "low","reason": ["Policy: Repeated Visits to Potentially Malicious address","Threat: Possible C2 Communication"],"entity": "Activityip","workflowName": "SOCTeamReview","url": "https://saaspocapp2t14wptp.securonix.net/Snypr/configurableDashboards/view?&type=incident&id=100317","isWhitelisted": false,"watchlisted": false}]}}}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given the required parameters, it returns a confirmation.' {
            $response = New-SecuronixIncident -Url $url -Token $token `
                -ViolationName 'Repeated Visits to Potentially Malicious address' `
                -DatasourceName 'Websense Proxy' -EntityType 'Activityip' `
                -EntityName '134.119.189.29' -Workflow 'SOCTeamReview'
        }
        It 'Given positional parameters, it returns a confirmation.' {
            $response = New-SecuronixIncident $url $token `
                'Repeated Visits to Potentially Malicious address' `
                'Websense Proxy' 'Activityip' '134.119.189.29' 'SOCTeamReview'
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
    }
}

Describe 'Add-SecuronixViolationScore' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Violation score updated for AA01MAC, Policyname:All Resources - AD04Dataset - 09 Nov 2020 by 5.0 from SOAR API"],"result": []}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given the required parameters, it returns a confirmation.' {
            $response = Add-SecuronixViolationScore -Url $url -Token $token `
                -ScoreIncrement 1 -TenantName 'Automationtenant' `
                -ViolationName 'policy' -PolicyCategory 'category' `
                -EntityType 'Users' -EntityName 'xyz' -ResourceGroupname 'rgGroup' `
                -ResourceName 'resource'
        }
        It 'Given positional parameters, it returns a confirmation.' {
            $response = Add-SecuronixViolationScore $url $token 1 `
                'Automationtenant' 'policy' 'category' 'Users' 'xyz' 'rgGroup' `
                'resource'
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
    }
}

AfterAll {
    Remove-Module Securonix.CLI
}