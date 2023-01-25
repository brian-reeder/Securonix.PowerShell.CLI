# Invoke-Pester -Output Detailed .\Test\*.Tests.ps1
[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessage(
    'PSUseDeclaredVarsMoreThanAssignments', '',
    Justification='PSSA does not properly detect for Pester scripts'
)]
Param()

BeforeAll {
    Remove-Module Securonix.CLI -ErrorAction SilentlyContinue
    Import-Module $PSScriptRoot\..\..\Securonix.CLI.psd1

    $config = Import-PowerShellDataFile -Path "$PSScriptRoot\config.psd1"

    $instance = $config.instance
    $url      = $config.url
    $username = $config.username
    $password = $config.password
}

Describe 'Get-SecuronixResourcegroupList' {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password
        }
        It 'Given required parameters, it returns all resource groups.' {
            $response = Get-SecuronixResourcegroupList -Url $url -Token $token
        }
        It 'Given positional parameters, it returns all resource groups.' {
            $response = Get-SecuronixResourcegroupList $url $token
        }
        AfterEach {
            $response.Count | Should -BeGreaterThan 0
        }
    }
    Context "When connection is set" {
        BeforeAll {
            Connect-SecuronixApi -Instance $instance -Username $username `
                -Password $password
        }
        It 'Given no parameters, it returns all resource groups.' {
            $response = Get-SecuronixResourcegroupList
        }
        AfterEach {
            $response.Count | Should -BeGreaterThan 0
        }
        AfterAll {
            $env:scnx_url   = ''
            $env:scnx_token = ''
        }
    }
}

Describe 'Get-SecuronixPolicyList' {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password
        }
        It 'Given required parameters, it returns all configured policies.' {
            $response = Get-SecuronixPolicyList -Url $url -Token $token
        }
        It 'Given positional parameters, it returns all configured policies.' {
            $response = Get-SecuronixPolicyList $url $token
        }
        AfterEach {
            $response.Count | Should -BeGreaterThan 0
        }
    }
    Context "When connection is set" {
        BeforeAll {
            Connect-SecuronixApi -Instance $instance -Username $username `
                -Password $password
        }
        It 'Given no parameters, it returns all configured policies.' {
            $response = Get-SecuronixPolicyList
        }
        AfterEach {
            $response.Count | Should -BeGreaterThan 0
        }
        AfterAll {
            $env:scnx_url   = ''
            $env:scnx_token = ''
        }
    }
}

Describe 'Get-SecuronixPeerGroupsList' {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password
        }
        It 'Given required parameters, it returns all user peer groups.' {
            $response = Get-SecuronixPeerGroupsList -Url $url -Token $token
        }
        It 'Given positional parameters, it returns all user peer groups.' {
            $response = Get-SecuronixPeerGroupsList $url $token
        }
        AfterEach {
            $response.Count | Should -BeGreaterThan 0
        }
    }
    Context "When connection is set" {
        BeforeAll {
            Connect-SecuronixApi -Instance $instance -Username $username `
                -Password $password
        }
        It 'Given no parameters, it returns all user peer groups.' {
            $response = Get-SecuronixPeerGroupsList
        }
        AfterEach {
            $response.Count | Should -BeGreaterThan 0
        }
        AfterAll {
            $env:scnx_url   = ''
            $env:scnx_token = ''
        }
    }
}

AfterAll {
    Remove-Module Securonix.CLI
}