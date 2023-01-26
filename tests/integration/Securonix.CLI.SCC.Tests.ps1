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

    $tenant = $config.tenantname

    $timestart_epoch = $config.timestart.epoch
    $timeend_epoch   = $config.timeend30d.epoch

    $timestart_date = $config.timestart.datetime
    $timeend_date   = $config.timeend30d.datetime

    $violatorName = $config.violatorname
}

Describe 'Get-SecuronixThreats' -Skip:($disable."Get-SecuronixThreats") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password
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
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixEntityThreatDetails' -Skip:($disable."Get-SecuronixEntityThreatDetails") {
    It 'Tests have not been implemented. See issue #81' {
        $null | Should -Not -BeNullOrEmpty
    }
}

Describe 'Get-SecuronixTopThreats' -Skip:($disable."Get-SecuronixTopThreats") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password
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
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixTopViolations' -Skip:($disable."Get-SecuronixTopViolations") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password
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
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixTopViolators' -Skip:($disable."Get-SecuronixTopViolators") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password
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
    Remove-Module Securonix.CLI*
}