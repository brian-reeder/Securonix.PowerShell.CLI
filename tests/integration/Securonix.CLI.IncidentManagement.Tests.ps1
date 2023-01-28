# Invoke-Pester -Output Detailed .\Test\*.Tests.ps1
[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessage(
    'PSUseDeclaredVarsMoreThanAssignments', '',
    Justification='PSSA does not properly detect for Pester scripts'
)]
Param()

$disable = (Import-PowerShellDataFile -Path "$PSScriptRoot\config.psd1").disable

BeforeAll {
    $modulepath = "$PSScriptRoot\..\..\src\Securonix.CLI\Securonix.CLI.psd1"

    Remove-Module Securonix.CLI* -ErrorAction SilentlyContinue
    Import-Module $modulepath

    $config = Import-PowerShellDataFile -Path "$PSScriptRoot\config.psd1"

    $instance = $config.instance
    $url      = $config.url
    $username = $config.username
    $password = $config.password

    $incidentid   = $config.incidentid
    $status       = $config.status
    $workflowname = $config.workflowname

    $timestart_epoch = $config.timestart.epoch
    $timeend_epoch   = $config.timeend30d.epoch

    $timestart_datetime = $config.timestart.datetime
    $timeend_datetime   = $config.timeend30d.datetime
}

Describe 'Get-SecuronixIncident' -Skip:($disable."Get-SecuronixIncident") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given required parameters, it returns the inc details.' {
            $response = Get-SecuronixIncident -Url $Url -Token $Token `
                -IncidentId $incidentid
        }
        It 'Given positional parameters, it returns the inc details.' {
            $response = Get-SecuronixIncident $Url $Token $incidentid
        }
        AfterEach {
            $response.incidentId | Should -be $incidentid
        }
    }
}

Describe 'Get-SecuronixIncidentStatus' -Skip:($disable."Get-SecuronixIncidentStatus") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given required parameters, it returns the incident status.' {
            $response = Get-SecuronixIncidentStatus -Url $url `
                -Token $token -IncidentId $incidentid
        }
        It 'Given positional parameters, it returns the incident status.' {
            $response = Get-SecuronixIncidentStatus $url $token $incidentid
        }
        AfterEach {
            $response.GetType() | Should -Be 'String'
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixIncidentWorkflowName' -Skip:($disable."Get-SecuronixIncidentWorkflowName") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given required parameters, it returns an incs workflow.' {
            $response = Get-SecuronixIncidentWorkflowName -Url $url `
                -Token $token -IncidentId $incidentid
        }
        It 'Given positional parameters, it returns an incs workflow.' {
            $response = Get-SecuronixIncidentWorkflowName $url $token `
                $incidentid
        }
        AfterEach {
            $response.GetType() | Should -Be 'String'
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixIncidentActionList' -Skip:($disable."Get-SecuronixIncidentActionList") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given required parameters, it returns the list of actions.' {
            $response = Get-SecuronixIncidentActionList -Url $url -Token $token `
                -IncidentId $incidentid
        }
        It 'Given positional parameters, it returns the list of actions.' {
            $response = Get-SecuronixIncidentActionList $url $token $incidentid
        }
        AfterEach {
            $response.actionDetails | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Confirm-SecuronixIncidentAction' -Skip:($disable."Confirm-SecuronixIncidentAction") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given required parameters, it returns the action details.' {
            $response = Confirm-SecuronixIncidentAction -Url $url `
                -Token $token -IncidentId $incidentid -ActionName 'Claim'
        }
        It 'Given positional parameters, it returns the action details.' {
            $response = Confirm-SecuronixIncidentAction $url $token `
                $incidentid 'Claim'
        }
        AfterEach {
            $response.actionDetails | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixWorkflowsList' -Skip:($disable."Get-SecuronixWorkflowsList") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given required parameters, it returns a list of workflows.' {
            $response = Get-SecuronixWorkflowsList -Url $url -Token $token
        }
        It 'Given positional parameters, it returns a list of workflows.' {
            $response = Get-SecuronixWorkflowsList $url $token
        }
        AfterEach {
            $response.GetType().BaseType | Should -Be 'Array'
            $response.Count | Should -BeGreaterThan 0
        }
    }
}

Describe 'Get-SecuronixWorkflowDefinition' -Skip:($disable."Get-SecuronixWorkflowDefinition") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given required parameters, it returns the workflow details.' {
            $response = Get-SecuronixWorkflowDefinition -Url $url `
                -Token $token -WorkflowName $workflowname
        }
        It 'Given positional parameters, it returns the workflow details.' {
            $response = Get-SecuronixWorkflowDefinition $url $token `
                $workflowname
        }
        AfterEach {
            $response.$workflowname | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixWorkflowDefaultAssignee' -Skip:($disable."Get-SecuronixWorkflowDefaultAssignee") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given required parameters, it returns the default assignee.' {
            $response = Get-SecuronixWorkflowDefaultAssignee -Url $url `
                -Token $token -WorkflowName $workflowname
        }
        It 'Given positional parameters, it returns the default assignee.' {
            $response = Get-SecuronixWorkflowDefaultAssignee $url $token `
                $workflowname
        }
        AfterEach {
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixIncidentsList' -Skip:($disable."Get-SecuronixIncidentsList") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given only required parameters, it returns a list of incs.' {
            $response = Get-SecuronixIncidentsList -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch `
                -RangeType 'updated'
        }
        It 'Given datetime, it returns a list of events.' {
            $response = Get-SecuronixIncidentsList -Url $url -Token $token `
                -TimeStart $timestart_datetime -TimeEnd $timeend_datetime `
                -RangeType 'updated'
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixIncidentsList -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch `
                -RangeType 'updated' -Status $status `
                -Max 1 -Offset 0
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixIncidentsList $url $token `
                $timestart_epoch $timeend_epoch 'updated'
        }
        AfterEach {
            $response | Should -not -BeNullOrEmpty
        }
    }
}

# TODO: Write test case for incident attachments
Describe 'Get-SecuronixIncidentAttachments' -Skip:($disable."Get-SecuronixIncidentAttachments") {
    It 'Tests have not been implemented. See issue #62' {
        $null | Should -Not -BeNullOrEmpty
    }
}

# TODO: Write test case for child incidents
Describe 'Get-SecuronixChildIncidentList' -Skip:($disable."Get-SecuronixChildIncidentList") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given required parameters, it returns a list of inc ids.' {
        }
        It 'Given positional parameters, it returns a list of inc ids.' {
        }
        AfterEach {
        }
    }
}

Describe 'Get-SecuronixIncidentActivityHistory' -Skip:($disable."Get-SecuronixIncidentActivityHistory") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given required parameters, it returns the incident history.' {
            $response = Get-SecuronixIncidentActivityHistory -Url $url `
                -Token $token -IncidentId $incidentid
        }
        It 'Given positional parameters, it returns the incident history.' {
            $response = Get-SecuronixIncidentActivityHistory $url $token `
                $incidentid
        }
        AfterEach {
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixThreatActionList' -Skip:($disable."Get-SecuronixThreatActionList") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given the required parameters, it returns a list of actions.' {
            $response = Get-SecuronixThreatActionList -Url $url -Token $token
        }
        It 'Given the positional parameters, it returns a list of actions.' {
            $response = Get-SecuronixThreatActionList $url $token
        }
        AfterEach {
            $response | Should -not -BeNullOrEmpty
        }
    }
}

# TODO: Write tests for functions that make changes to Securonix environment.
Describe 'Update-SecuronixIncident' -Skip:($disable."Update-SecuronixIncident") {
    It 'Tests have not been implemented. See issue #80' {
        $null | Should -Not -BeNullOrEmpty
    }
}

Describe 'Add-SecuronixComment' -Skip:($disable."Add-SecuronixComment") {
    It 'Tests have not been implemented. See issue #80' {
        $null | Should -Not -BeNullOrEmpty
    }
}

Describe 'Update-SecuronixCriticality' -Skip:($disable."Update-SecuronixCriticality") {
    It 'Tests have not been implemented. See issue #80' {
        $null | Should -Not -BeNullOrEmpty
    }
}

Describe 'New-SecuronixIncident' -Skip:($disable."New-SecuronixIncident") {
    It 'Tests have not been implemented. See issue #80' {
        $null | Should -Not -BeNullOrEmpty
    }
}

Describe 'Add-SecuronixViolationScore' -Skip:($disable."Add-SecuronixViolationScore") {
    It 'Tests have not been implemented. See issue #80' {
        $null | Should -Not -BeNullOrEmpty
    }
}

AfterAll {
    Remove-Module Securonix.CLI*
}