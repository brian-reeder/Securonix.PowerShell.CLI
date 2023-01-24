# Invoke-Pester -Output Detailed .\Test\*.Tests.ps1
BeforeAll {
    Remove-Module Securonix.CLI -ErrorAction SilentlyContinue
    Import-Module $PSScriptRoot\..\..\Securonix.CLI.psd1

    $url = 'https://dundermifflin.securonix.net/Snypr'
    $ins = 'dundermifflin'
    $token = '530bf219-5360-41d3-81d1-8b4d6f75956d'

    $username = 'jhalpert'
    $password = 'sEcUrEpAsSwOrD'
}

Describe 'New-SecuronixApiToken' {
    Context "When credentials are valid" {
        BeforeEach {
            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith  { return $token } `
                -ModuleName Securonix.CLI.Auth
        }
        It 'Given only the required parameters, it returns a token.' {
            $token = New-SecuronixApiToken -Url $url -Username $username -Password $password
        }
        It 'Given a validity, it returns a token.' {
            $token = New-SecuronixApiToken -Url $url -Username $username -Password $password `
                -Validity 1
        }
        It 'Given only required positional parameters, it returns a token.' {
            $token = New-SecuronixApiToken $url $username $password
        }
        It 'Given all positional parameters, it returns a token.' {
            $token = New-SecuronixApiToken $url $username $password 1
        }
        AfterEach {
            Should -InvokeVerifiable
            $token | Should -Be $token
        }
    }
}

Describe 'Connect-SecuronixApi' {
    Context "When credentials are valid" {
        BeforeEach {
            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith  { return $token } `
                -ModuleName Securonix.CLI.Auth
        }
        It 'Given the url required parameters, it sets a connection.' {
            $response = Connect-SecuronixApi -Url $Url -Username $username `
                -Password $password
        }
        It 'Given the instance required parameters, it sets a connection.' {
            $response = Connect-SecuronixApi -Instance $ins `
                -Username $username -Password $password
        }
        It 'Given the url optional parameters, it sets a connection.' {
            $response = Connect-SecuronixApi -Url $Url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given the instance optional parameters, it sets a connection.' {
            $response = Connect-SecuronixApi -Instance $ins `
                -Username $username -Password $password -Validity 1
        }
        It 'Given the positional parameters, it sets a connection.' {
            $response = Connect-SecuronixApi $ins $username `
                $password
        }
        AfterEach {
            Should -InvokeVerifiable
            $env:scnx_token | Should -Be $token
            $env:scnx_url   | Should -Be $url
            $response       | Should -Be 'Connected'

            $env:scnx_token = ''
            $env:scnx_url   = ''
        }
    }
}

Describe 'Confirm-SecuronixApiToken' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith  { return 'Valid' } `
                -ModuleName Securonix.CLI.Auth
        }
        It 'Given the required parameters, it returns "Valid".' {
            $response = Confirm-SecuronixApiToken -Url $Url -Token $token
        }
        It 'Given the required positional parameters, it returns "Valid".' {
            $response = Confirm-SecuronixApiToken $Url $token
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -be 'Valid'
        }
    }
    Context "When connection is set" {
        BeforeAll {
            $env:scnx_url   = $url
            $env:scnx_token = $token

            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith  { return 'Valid' } `
                -ModuleName Securonix.CLI.Auth
        }
        It 'Given the required parameters, it returns "Valid".' {
            $response = Confirm-SecuronixApiToken
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -be 'Valid'
        }
        AfterAll {
            $env:scnx_url   = ''
            $env:scnx_token = ''
        }
    }
}

Describe 'Update-SecuronixApiToken' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith  { return 'Success' } `
                -ModuleName Securonix.CLI.Auth
        }
        It 'Given the required parameters, it returns "Success".' {
            $response = Update-SecuronixApiToken -Url $Url -Token $token
        }
        It 'Given the required positional parameters, it returns "Success".' {
            $response = Update-SecuronixApiToken $Url $token
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -be 'Success'
        }
    }
    Context "When connection is set" {
        BeforeEach {
            $env:scnx_url   = $url
            $env:scnx_token = $token

            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith  { return 'Success' } `
                -ModuleName Securonix.CLI.Auth
        }
        It 'Given the required parameters, it returns "Valid".' {
            $response = Update-SecuronixApiToken
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -be 'Success'
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