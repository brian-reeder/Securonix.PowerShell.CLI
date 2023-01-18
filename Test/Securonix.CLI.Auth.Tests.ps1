# Invoke-Pester -Output Detailed .\Test\*.Tests.ps1
BeforeAll {
    Remove-Module Securonix.CLI -ErrorAction SilentlyContinue
    Import-Module $PSScriptRoot\..\Securonix.CLI.psd1

    $Url = 'https://dundermifflin.securonix.net/Snypr'

}

Describe 'New-SecuronixApiToken' {
    Context "When credentials are valid" {
        BeforeEach {
            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith  { return '530bf219-5360-41d3-81d1-8b4d6f75956d' } `
                -ModuleName Securonix.CLI.Auth
        }
        It 'Given only the required parameters, it returns a token.' {
            $token = New-SecuronixApiToken -Url $Url -Username 'jhalpert' -Password 'sEcUrEpAsSwOrD'

            Should -InvokeVerifiable
            $token | Should -Be '530bf219-5360-41d3-81d1-8b4d6f75956d'
        }
        It 'Given a validity, it returns a token.' {
            $token = New-SecuronixApiToken -Url $Url -Username 'jhalpert' -Password 'sEcUrEpAsSwOrD' -Validity 7

            Should -InvokeVerifiable
            $token | Should -Be '530bf219-5360-41d3-81d1-8b4d6f75956d'
        }
        It 'Given only required positional parameters, it returns a token.' {
            $token = New-SecuronixApiToken $Url 'jhalpert' 'sEcUrEpAsSwOrD' 7

            Should -InvokeVerifiable
            $token | Should -Be '530bf219-5360-41d3-81d1-8b4d6f75956d'
        }
        It 'Given all positional parameters, it returns a token.' {
            $token = New-SecuronixApiToken $Url 'jhalpert' 'sEcUrEpAsSwOrD'

            Should -InvokeVerifiable
            $token | Should -Be '530bf219-5360-41d3-81d1-8b4d6f75956d'
        }
    }
}

Describe 'Connect-SecuronixApi' {
    Context "When credentials are valid" {
        BeforeEach {
            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith  { return '530bf219-5360-41d3-81d1-8b4d6f75956d' } `
                -ModuleName Securonix.CLI.Auth
        }
        It 'Given the url required parameters, it sets a connection.' {
            $response = Connect-SecuronixApi -Url $Url -Username 'jhalpert' -Password 'sEcUrEpAsSwOrD'

            Should -InvokeVerifiable
            
            $env:scnx_token | Should -Be '530bf219-5360-41d3-81d1-8b4d6f75956d'
            $env:scnx_url   | Should -Be $Url
            $response       | Should -Be 'Connected'
        }
        It 'Given the instance required parameters, it sets a connection.' {
            $response = Connect-SecuronixApi -Instance 'dundermifflin' -Username 'jhalpert' -Password 'sEcUrEpAsSwOrD'

            Should -InvokeVerifiable
            
            $env:scnx_token | Should -Be '530bf219-5360-41d3-81d1-8b4d6f75956d'
            $env:scnx_url   | Should -Be $Url
            $response       | Should -Be 'Connected'
        }
        It 'Given the url optional parameters, it sets a connection.' {
            $response = Connect-SecuronixApi -Url $Url -Username 'jhalpert' -Password 'sEcUrEpAsSwOrD' -Validity 1

            Should -InvokeVerifiable
            
            $env:scnx_token | Should -Be '530bf219-5360-41d3-81d1-8b4d6f75956d'
            $env:scnx_url   | Should -Be $Url
            $response       | Should -Be 'Connected'
        }
        It 'Given the instance optional parameters, it sets a connection.' {
            $response = Connect-SecuronixApi -Instance 'dundermifflin' -Username 'jhalpert' -Password 'sEcUrEpAsSwOrD' -Validity 1

            Should -InvokeVerifiable
            
            $env:scnx_token | Should -Be '530bf219-5360-41d3-81d1-8b4d6f75956d'
            $env:scnx_url   | Should -Be $Url
            $response       | Should -Be 'Connected'
        }
        It 'Given the positional parameters, it sets a connection.' {
            $response = Connect-SecuronixApi 'dundermifflin' 'jhalpert' 'sEcUrEpAsSwOrD'

            Should -InvokeVerifiable
            
            $env:scnx_token | Should -Be '530bf219-5360-41d3-81d1-8b4d6f75956d'
            $env:scnx_url   | Should -Be $Url
            $response       | Should -Be 'Connected'
        }
        AfterEach {
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
            $response = Confirm-SecuronixApiToken -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d'
            
            Should -InvokeVerifiable
            $response | Should -be 'Valid'
        }
        It 'Given the required positional parameters, it returns "Valid".' {
            $response = Confirm-SecuronixApiToken $Url '530bf219-5360-41d3-81d1-8b4d6f75956d'
            
            Should -InvokeVerifiable
            $response | Should -be 'Valid'
        }
    }
    Context "When connection is set" {
        BeforeEach {
            $env:scnx_url   = 'https://dundermifflin.securonix.net/Snypr'
            $env:scnx_token = '530bf219-5360-41d3-81d1-8b4d6f75956d'

            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith  { return 'Valid' } `
                -ModuleName Securonix.CLI.Auth
        }
        It 'Given the required parameters, it returns "Valid".' {
            $response = Confirm-SecuronixApiToken
            
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
            $token = Update-SecuronixApiToken -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d'
            
            Should -InvokeVerifiable
            $token | Should -be 'Success'
        }
        It 'Given the required positional parameters, it returns "Success".' {
            $token = Update-SecuronixApiToken $Url '530bf219-5360-41d3-81d1-8b4d6f75956d'
            
            Should -InvokeVerifiable
            $token | Should -be 'Success'
        }
    }
    Context "When connection is set" {
        BeforeEach {
            $env:scnx_url   = 'https://dundermifflin.securonix.net/Snypr'
            $env:scnx_token = '530bf219-5360-41d3-81d1-8b4d6f75956d'

            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith  { return 'Success' } `
                -ModuleName Securonix.CLI.Auth
        }
        It 'Given the required parameters, it returns "Valid".' {
            $response = Update-SecuronixApiToken
            
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