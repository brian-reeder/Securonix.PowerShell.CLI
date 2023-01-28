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
}

Describe 'New-SecuronixApiToken' -Skip:($disable."New-SecuronixApiToken") {
    Context "When credentials are valid" {
        It 'Given only the required parameters, it returns a token.' {
            $token = New-SecuronixApiToken -Url $url -Username $username -Password $password
        }
        It 'Given a validity, it returns a token.' {
            $token = New-SecuronixApiToken -Url $url -Username $username -Password $password -Validity 7
        }
        It 'Given only required positional parameters, it returns a token.' {
            $token = New-SecuronixApiToken $url $username $password
        }
        It 'Given all positional parameters, it returns a token.' {
            $token = New-SecuronixApiToken $url $username $password 7
        }
        AfterEach {
            $token | Should -Match '[\w]{8}(\-[\w]{4}){3}\-[\w]{12}'
        }
    }
}

Describe 'Connect-SecuronixApi' -Skip:($disable."Connect-SecuronixApi") {
    Context "When credentials are valid" {
        It 'Given the url required parameters, it sets a connection.' {
            $response = Connect-SecuronixApi -Url $url -Username $username `
                -Password $password
        }
        It 'Given the url optional parameters, it sets a connection.' {
            $response = Connect-SecuronixApi -Url $url -Username $username `
                -Password $password -Validity 7
        }
        It 'Given the instance required parameters, it sets a connection.' {
            $response = Connect-SecuronixApi -Instance $instance -Username $username `
                -Password $password
        }
        It 'Given the instance optional parameters, it sets a connection.' {
            $response = Connect-SecuronixApi -Instance $instance -Username $username `
                -Password $password -Validity 7
        }
        It 'Given the positional parameters, it sets a connection.' {
            $response = Connect-SecuronixApi $instance $username $password
        }
        AfterEach {
            $env:scnx_token | Should -Match '[\w]{8}(\-[\w]{4}){3}\-[\w]{12}'
            $env:scnx_url   | Should -Be $url
            $response       | Should -Be 'Connected'

            $env:scnx_token = ''
            $env:scnx_url   = ''
        }
    }
}

Describe 'Confirm-SecuronixApiToken' -Skip:($disable."Confirm-SecuronixApiToken") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username -Password $password
        }
        It 'Given the required parameters, it returns "Valid".' {
            $response = Confirm-SecuronixApiToken -Url $url -Token $token
        }
        It 'Given the required positional parameters, it returns "Valid".' {
            $response = Confirm-SecuronixApiToken $url $token
        }
        AfterEach {
            $response | Should -be 'Valid'
        }
    }
    Context "When connection is set" {
        BeforeAll {
            Connect-SecuronixApi -Instance $instance -Username $username -Password $password
        }
        It 'Given the required parameters, it returns "Valid".' {
            $response = Confirm-SecuronixApiToken
        }
        AfterEach {
            $response | Should -be 'Valid'
        }
        AfterAll {
            $env:scnx_url   = ''
            $env:scnx_token = ''
        }
    }
}

Describe 'Update-SecuronixApiToken' -Skip:($disable."Update-SecuronixApiToken") {
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username -Password $password
        }
        It 'Given the required parameters, it returns "Success".' {
            $response = Update-SecuronixApiToken -Url $url -Token $token
        }
        It 'Given the required positional parameters, it returns "Success".' {
            $response = Update-SecuronixApiToken $url $token
        }
        AfterEach {
            $response | Should -be 'Success'
        }
    }
    Context "When connection is set" {
        BeforeAll {
            Connect-SecuronixApi -Instance $instance -Username $username -Password $password
        }
        It 'Given the required parameters, it returns "Valid".' {
            $response = Update-SecuronixApiToken
        }
        AfterEach {
            $response | Should -be 'Success'
        }
        AfterAll {
            $env:scnx_url   = ''
            $env:scnx_token = ''
        }
    }
}

AfterAll {
    Remove-Module Securonix.CLI*
}