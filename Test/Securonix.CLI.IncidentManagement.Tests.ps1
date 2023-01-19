# Invoke-Pester -Output Detailed .\Test\*.Tests.ps1
BeforeAll {
    Remove-Module Securonix.CLI -ErrorAction SilentlyContinue
    Import-Module $PSScriptRoot\..\Securonix.CLI.psd1

    $Url = 'https://dundermifflin.securonix.net/Snypr'

    $IncidentDetails         = ConvertFrom-Json '{"status": "OK","messages": ["Get incident details for incident ID [100107]"],"result": {"data": {"totalIncidents": 1.0,"incidentItems": [{"violatorText": "Cyndi Converse","lastUpdateDate": 1566232568502,"violatorId": "96","incidentType": "Policy","incidentId": "100107","incidentStatus": "COMPLETED","riskscore": 0.0,"assignedUser": "Admin Admin","priority": "low","reason": ["Resource: Symantec Email DLP","Policy: Emails with large File attachments","Threat: Data egress attempts"],"violatorSubText": "1096","entity": "Users","workflowName": "SOCTeamReview","url": "DunderMifflin.securonix.com/Snypr/configurableDashboards/view?&type=incident&id=100107","isWhitelisted": false,"watchlisted": false}]}}}'
    $WorkflowStatus          = ConvertFrom-Json '{"status": "OK","messages": ["Get incident status for incident ID [100107] - [COMPLETED]"],"result": {"status": "COMPLETED"}}'
    $WorkflowName            = ConvertFrom-Json '{"status": "OK","messages": ["Get incident workflow for incident ID [100107] - [SOCTeamReview]"],"result": {"workflow": "SOCTeamReview"}}'
    $ActionList              = ConvertFrom-Json '{"status": "OK","messages": ["Get possible actions for incident ID [100289], incident status [Open]"],"result": [{"actionDetails": [{"title": "Screen1","sections": {"sectionName": "Comments","attributes": [{"displayName": "Comments","attributeType": "textarea","attribute": "15_Comments","required": false}]}}],"actionName": "CLAIM","status": "CLAIMED"},{"actionDetails": [{"title": "Screen1","sections": {"sectionName": "Comments","attributes": [{"displayName": "Business Response","attributeType": "dropdown","values": ["Inaccurate alert-User not a HPA","Inaccurate alert-inaccurate log data","Inaccurate alert-host does not belong to our business","Need more information","Duplicate alert"],"attribute": "10_Business-Response","required": false},{"displayName": "Business Justification","attributeType": "text","attribute": "11_Business-Justification","required": false},{"displayName": "Remediation Performed","attributeType": "text","attribute": "12_Remediation-Performed","required": false},{"displayName": "Business Internal Use","attributeType": "text","attribute": "13_Business-Internal-Use","required": false},{"displayName": "Assign To Analyst","attributeType": "assignto","values": [{"key": "GROUP","value": "Administrators"},{"key": "GROUP","value": "SECURITYOPERATIONS"},{"key": "USER","value": "admin"},{"key": "USER","value": "auditor"},{"key": "USER","value": "useradmin"},{"key": "USER","value": "accessscanner"},{"key": "USER","value": "account08"},{"key": "USER","value": "account10"},{"key": "USER","value": "account06"},{"key": "USER","value": "account07"},{"key": "USER","value": "account02"},{"key": "USER","value": "account09"},{"key": "USER","value": "account01"},{"key": "USER","value": "account05"},{"key": "USER","value": "account03"},{"key": "USER","value": "account04"}],"attribute": "assigntouserid","required": true}]}}],"actionName": "ASSIGN TO ANALYST","status": "OPEN"},{"actionDetails": [{"title": "Screen1","sections": {"sectionName": "Comments","attributes": [{"displayName": "Comments","attributeType": "textarea","attribute": "15_Comments","required": false}]}}],"actionName": "ASSIGN TO SECOPS","status": "OPEN"}]}'
    $ActionClaim             = ConvertFrom-Json '{"status": "OK","messages": ["Check if action is possible and get list of parameters - Incident Id - [100289], action Name - [CLAIM], - status - [Open]"],"result": [{"actionDetails": [{"title": "Screen1","sections": {"sectionName": "Comments","attributes": [{"displayName": "Comments","attributeType": "textarea","attribute": "15_Comments","required": false}]}}],"actionName": "CLAIM","status": "CLAIMED"}]}'
    $WorkflowLists           = 
    $WorkflowDetails         = ConvertFrom-Json '{"status": "OK","messages": ["Workflow Details"],"result": {"SOCTeamReview": {"CLAIMED": [{"Status": "OPEN","Action": "ASSIGN TO ANALYST"},{"Status": "COMPLETED","Action": "ACCEPT RISK"},{"Status": "OPEN","Action": "RELEASE"},{"Status": "CLOSED","Action": "VIOLATION"},{"Status": "OPEN","Action": "ASSIGN TO SECOPS"}],"CLOSED": [{"Status": "PENDING VERIFICATION","Action": "CLAIM"},{"Status": "OPEN","Action": "ASSIGN TO ANALYST"},{"Status": "OPEN","Action": "RELEASE"}],"PENDING VERIFICATION": [{"Status": "COMPLETED","Action": "VERIFY"}],"OPEN": [{"Status": "OPEN","Action": "ASSIGN TO ANALYST"},{"Status": "CLAIMED","Action": "CLAIM"},{"Status": "OPEN","Action": "ASSIGN TO SECOPS"},{"Status": "Do Not Change","Action": "WhiteList_Action"}]}}}'
    $WorkflowDefaultAssignee = ConvertFrom-Json '{"status": "OK","messages": ["Default assignee for workflow [SOCTeamReview] - [admin]"],"result": {"type": "USER","value": "admin"}}'
    
    
    $IncidentHistory         = ConvertFrom-Json '{"status": "OK","messages": ["Get activity stream details for incident ID [20019]"],"result": {"activityStreamData": [{"caseid": "20019","actiontaken": "CREATED","status": "Open","comment": [],"eventTime": "Jan 21, 2020 2:33:37 AM","username": "Admin Admin","currentassignee": "admin","commentType": [],"currWorkflow": "SOCTeamReview"}]}}'
    $IncidentActions         = ConvertFrom-Json '{"status": "OK","messages": ["test Message 04"],"result": ["Mark as concern and create incident","Non-Concern","Mark in progress (still investigating)"]}'
    $ActionResponse          = ConvertFrom-Json '{"status": "OK","result": "submitted"}'
    $CommentResponse         = ConvertFrom-Json '{"status": "OK","messages": ["Add comment to incident id - [100289]"],"result": true}'
    $CriticalityResponse     = ConvertFrom-Json '{"status": "OK","messages": ["Criticality updated for incidents : [1727657,172992]"]}'
    $NewIncidentResponse     = ConvertFrom-Json '{"status": "OK","messages":["Get incident details for incident ID [100317]"],"result": {"data": {"totalIncidents": 1.0,"incidentItems": [{"violatorText": "134.119.189.29","lastUpdateDate": 1566337840264,"violatorId": "134.119.189.29","incidentType": "Policy","incidentId": "100317","incidentStatus": "Open","riskscore": 3.0,"assignedUser": "Admin Admin","priority": "low","reason": ["Policy: Repeated Visits to Potentially Malicious address","Threat: Possible C2 Communication"],"entity": "Activityip","workflowName": "SOCTeamReview","url": "https://saaspocapp2t14wptp.securonix.net/Snypr/configurableDashboards/view?&type=incident&id=100317","isWhitelisted": false,"watchlisted": false}]}}}'
    $ViolationScoreResponse  = ConvertFrom-Json '{"status": "OK","messages": ["Violation score updated for AA01MAC, Policyname:All Resources - AD04Dataset - 09 Nov 2020 by 5.0 from SOAR API"],"result": []}'
}

Describe 'Get-SecuronixIncident' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $IncidentDetails } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the incident workflow name.' {
            $response = Get-SecuronixIncident -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '100107'
            Should -InvokeVerifiable
            $response.incidentId | Should -be '100107'
        }
        It 'Given positional parameters, it returns the incident workflow name.' {
            $response = Get-SecuronixIncident 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' '100107'
            Should -InvokeVerifiable
            $response.incidentId | Should -be '100107'
        }
    }
}

Describe 'Get-SecuronixIncidentStatus' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $WorkflowStatus } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the incident workflow name.' {
            $response = Get-SecuronixIncidentStatus -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '100107'
            Should -InvokeVerifiable
            $response | Should -be 'COMPLETED'
        }
        It 'Given positional parameters, it returns the incident workflow name.' {
            $response = Get-SecuronixIncidentStatus 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' '100107'
            Should -InvokeVerifiable
            $response | Should -be 'COMPLETED'
        }
    }
}

Describe 'Get-SecuronixIncidentWorkflowName' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $WorkflowName } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the incident workflow name.' {
            $response = Get-SecuronixIncidentWorkflowName -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '100107'
            Should -InvokeVerifiable
            $response.workflow | Should -not -BeNullOrEmpty
        }
        It 'Given positional parameters, it returns the incident workflow name.' {
            $response = Get-SecuronixIncidentWorkflowName 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' '100107'
            Should -InvokeVerifiable
            $response.workflow | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixIncidentActions' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ActionList } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the list of actions.' {
            $response = Get-SecuronixIncidentActions -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '100107'
            Should -InvokeVerifiable
            $response.actionDetails | Should -not -BeNullOrEmpty
        }
        It 'Given positional parameters, it returns the list of actions.' {
            $response = Get-SecuronixIncidentActions 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' '100107'
            Should -InvokeVerifiable
            $response.actionDetails | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Confirm-SecuronixIncidentAction' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ActionClaim } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the action details.' {
            $response = Confirm-SecuronixIncidentAction -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '100107' -ActionName 'Claim'
            Should -InvokeVerifiable
            $response.actionDetails | Should -not -BeNullOrEmpty
        }
        It 'Given positional parameters, it returns the action details.' {
            $response = Confirm-SecuronixIncidentAction 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' '100107' 'Claim'
            Should -InvokeVerifiable
            $response.actionDetails | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixWorkflowsList' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Get all possible workflows"],"result": {"workflows": [{"workflow": "SOCTeamReview","type": "USER","value": "admin"},{"workflow": "ActivityOutlierWorkflow","type": "USER","value": "admin"},{"workflow": "AccessCertificationWorkflow","type": "USER","value": "admin"}]}}'

        $url   = 'https://DunderMifflin.securonix.com/Snypr'
        $token = '12345678-90AB-CDEF-1234-567890ABCDEF'
    }
    Context "When token is valid" {
        BeforeAll {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the list of workflows.' {
            $response = Get-SecuronixWorkflowsList -Url $url -Token $token
            
            Should -InvokeVerifiable
            $response.GetType().BaseType | Should -Be 'Array'
        }
        It 'Given positional parameters, it returns the list of workflows.' {
            $response = Get-SecuronixWorkflowsList $url $token

            Should -InvokeVerifiable
            $response.GetType().BaseType | Should -Be 'Array'
        }
    }
}

Describe 'Get-SecuronixWorkflowDetails' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $WorkflowDetails } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the workflow details.' {
            $response = Get-SecuronixWorkflowDetails -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WorkflowName 'SOCTeamReview'
            Should -InvokeVerifiable
            $response.SOCTeamReview | Should -not -BeNullOrEmpty
        }
        It 'Given positional parameters, it returns the workflow details.' {
            $response = Get-SecuronixWorkflowDetails 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' 'SOCTeamReview'
            Should -InvokeVerifiable
            $response.SOCTeamReview | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixWorkflowDefaultAssignee' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $WorkflowDefaultAssignee } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the default assignee.' {
            $response = Get-SecuronixWorkflowDefaultAssignee -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WorkflowName 'SOCTeamReview'
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
        It 'Given positional parameters, it returns the default assignee.' {
            $response = Get-SecuronixWorkflowDefaultAssignee 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' 'SOCTeamReview'
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixIncidentsList' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","result": {"data": {"totalIncidents": 1.0,"incidentItems": [{"violatorText": "Cyndi Converse","lastUpdateDate": 1566293234026,"violatorId": "96","incidentType": "RISK MODEL","incidentId": "100181","incidentStatus": "COMPLETED","riskscore": 0.0,"assignedUser": "Account Access 02","assignedGroup": "Administrators","priority": "None","reason": ["Resource: Symantec Email DLP"],"violatorSubText": "1096","entity": "Users","workflowName": "SOCTeamReview","url": "DunderMifflin.securonix.com/Snypr/configurableDashboards/view?&type=incident&id=100181","isWhitelisted": false,"watchlisted": false}]}}}'

        $url   = 'https://DunderMifflin.securonix.com/Snypr'
        $token = '12345678-90AB-CDEF-1234-567890ABCDEF'
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

            Should -InvokeVerifiable
            $response.Count | Should -Be 1
        }
        It 'Given datetime, it returns a list of events.' {
            $response = Get-SecuronixIncidentsList -Url $url `
                -Token $token -TimeStart '08/19/19 21:17:53' `
                -TimeEnd '08/20/19 21:17:53' -RangeType 'updated'
            
            Should -InvokeVerifiable
            $response.Count | Should -Be 1
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixIncidentsList -Url $url `
                -Token $token -TimeStart '1566249473000' `
                -TimeEnd '1566335873000' -RangeType 'updated' `
                -Status 'Claimed' -AllowChildCases -Max 1 -Offset 0

                Should -InvokeVerifiable
                $response.Count | Should -Be 1
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixIncidentsList $url $token `
                '1566249473000' '1566335873000' 'updated'
            
            Should -InvokeVerifiable
            $response.Count | Should -Be 1
        }
    }
}

<#
# TODO: Set $IncidentAttachmentList
Describe 'Get-SecuronixIncidentAttachments' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $IncidentAttachmentList } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns a list of incident attachments.' {
            $response = Get-SecuronixIncidentAttachments -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '20019'
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
        It 'Given time (epoch) parameters, it returns a list of incident attachments.' {
            $response = Get-SecuronixIncidentAttachments -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '20019' -TimeStart '1672617600' -TimeEnd '1672703999'
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
        It 'Given time (datetime) parameters, it returns a list of incident attachments.' {
            $response = Get-SecuronixIncidentAttachments -Whatif-Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '20019' -TimeStart '01/02/2023 00:00:00-0' -TimeEnd '01/02/2023 23:59:59-0'
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
        It 'Given positional parameters, it returns a list of incident attachments.' {
            $response = Get-SecuronixIncidentAttachments 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' '20019'
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
        It 'Given optional parameters, it returns a list of incident attachments.' {
            $response = Get-SecuronixIncidentAttachments -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '20019' -AttachmentType 'csv'
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
    }
}
#>

Describe 'Get-SecuronixChildIncidents' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": ["Get child case details for incident ID [20019]"],"result": ["20046","20073","20100","20127","20154","20181","20208","20235"]}'

        $url   = 'https://DunderMifflin.securonix.com/Snypr'
        $token = '12345678-90AB-CDEF-1234-567890ABCDEF'

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

            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
        It 'Given positional parameters, it returns a list of incident ids.' {
            $response = Get-SecuronixChildIncidents $url $token $id
            
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixIncidentActivityHistory' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $IncidentHistory } `
                -ModuleName Securonix.CLI.IncidentManagement
        }
        It 'Given required parameters, it returns the activity stream details.' {
            $response = Get-SecuronixIncidentActivityHistory -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '20019'
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
        It 'Given positional parameters, it returns the activity stream details.' {
            $response = Get-SecuronixIncidentActivityHistory 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF' '20019'
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
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