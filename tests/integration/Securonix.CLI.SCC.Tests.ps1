# Invoke-Pester -Output Detailed .\Test\*.Tests.ps1
[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessage(
    'PSUseDeclaredVarsMoreThanAssignments', '',
    Justification='PSSA does not properly detect for Pester scripts'
)]
Param()

BeforeDiscovery {
    $disable = (Import-PowerShellDataFile -Path "$PSScriptRoot\config.psd1").disable
}

BeforeAll {
    $modulepath = "$PSScriptRoot\..\..\src\Securonix.CLI\Securonix.CLI.psd1"

    Remove-Module Securonix.CLI* -ErrorAction SilentlyContinue
    Import-Module $modulepath

    $config = Import-PowerShellDataFile -Path "$PSScriptRoot\config.psd1"

    $instance = $config.instance
    $url      = $config.url
    $username = $config.username
    $password = $config.password

    $tenant = $config.tenantname

    $timestart_epoch = $config.timestart.epoch
    $timeend_epoch   = $config.timeend30d.epoch

    $timestart_date = $config.timestart.datetime
    $timeend_date   = $config.timeend30d.datetime

    $violatorName = $config.violatorname
}

Describe 'Get-SecuronixThreatList' -Skip:($disable."Get-SecuronixThreatList") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password
        }
        It 'Given required parameters, it returns a list of threats.' {
            $response = Get-SecuronixThreatList -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch `
                -TenantName $tenant
        }
        It 'Given datetime parameters, it returns a list of threats.' {
            $response = Get-SecuronixThreatList -Url $url -Token $token `
                -TimeStart $timestart_date -TimeEnd $timeend_date `
                -TenantName $tenant
        }
        It 'Given optional parameters, it returns a list of threats.' {
            $response = Get-SecuronixThreatList -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch -Offset 1 `
                -Max 2 -TenantName $tenant
        }
        It 'Given positional parameters, it returns a list of threats.' {
            $response = Get-SecuronixThreatList $url $token $timestart_epoch `
                $timeend_epoch 1 2 $tenant
        }
        AfterEach {
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixEntityThreatModel' -Skip:($disable."Get-SecuronixEntityThreatModel") {
    It 'Tests have not been implemented. See issue #81' {
        $null | Should -Not -BeNullOrEmpty
    }
}

Describe 'Get-SecuronixTopThreatsList' -Skip:($disable."Get-SecuronixTopThreatsList") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password
        }
        It 'Given required parameters for hours, it returns a list of threats.' {
            $response = Get-SecuronixTopThreatsList -Url $url -Token $token `
                -Hours 1260
        }
        It 'Given required parameters for days, it returns a list of threats.' {
            $response = Get-SecuronixTopThreatsList -Url $url -Token $token `
                -Days 30
        }
        It 'Given optional parameters for hours, it returns a list of threats.' {
            $response = Get-SecuronixTopThreatsList -Url $url -Token $token `
                -Hours 1260 -Offset 1 -Max 2
        }
        It 'Given optional parameters for days, it returns a list of threats.' {
            $response = Get-SecuronixTopThreatsList -Url $url -Token $token `
                -Days 30 -Offset 1 -Max 2
        }
        It 'Given positional parameters, it returns a list of threats.' {
            $response = Get-SecuronixTopThreatsList $url $token  -Days 1
        }
        AfterEach {
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixTopViolationsList' -Skip:($disable."Get-SecuronixTopViolationsList") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password
        }
        It 'Given required parameters for hours, it returns a list of violations.' {
            $response = Get-SecuronixTopViolationsList -Url $url -Token $token `
                -Hours 1260
        }
        It 'Given required parameters for days, it returns a list of violations.' {
            $response = Get-SecuronixTopViolationsList -Url $url -Token $token `
                -Days 30
        }
        It 'Given optional parameters for hours, it returns a list of violations.' {
            $response = Get-SecuronixTopViolationsList -Url $url -Token $token `
                -Hours 1260 -Offset 1 -Max 2
        }
        It 'Given optional parameters for days, it returns a list of violations.' {
            $response = Get-SecuronixTopViolationsList -Url $url -Token $token `
                -Days 30 -Offset 1 -Max 2
        }
        It 'Given positional parameters, it returns a list of violations.' {
            $response = Get-SecuronixTopViolationsList $url $token  -Days 1
        }
        AfterEach {
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixTopViolatorsList' -Skip:($disable."Get-SecuronixTopViolatorsList") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password
        }
        It 'Given required parameters for hours, it returns a list of violations.' {
            $response = Get-SecuronixTopViolatorsList -Url $url -Token $token `
                -Hours 1260
        }
        It 'Given required parameters for days, it returns a list of violations.' {
            $response = Get-SecuronixTopViolatorsList -Url $url -Token $token `
                -Days 30
        }
        It 'Given optional parameters for hours, it returns a list of violations.' {
            $response = Get-SecuronixTopViolatorsList -Url $url -Token $token `
                -Hours 1260 -Offset 1 -Max 2
        }
        It 'Given optional parameters for days, it returns a list of violations.' {
            $response = Get-SecuronixTopViolatorsList -Url $url -Token $token `
                -Days 30 -Offset 1 -Max 2 -Name $violatorName
        }
        It 'Given positional parameters, it returns a list of violations.' {
            $response = Get-SecuronixTopViolatorsList $url $token  -Days 1
        }
        AfterEach {
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

AfterAll {
    Remove-Module Securonix.CLI*
}