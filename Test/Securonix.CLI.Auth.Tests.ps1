# Invoke-Pester -Output Detailed .\Test\*.Tests.ps1
BeforeAll {
    Remove-Module Securonix.CLI -ErrorAction SilentlyContinue
    Import-Module $PSScriptRoot\..\Securonix.CLI.psd1

    $Url = 'https://dundermifflin.securonix.net/Snypr'

}

Describe 'New-SecuronixApiToken' {
    Context "When credentials are valid" {
        It 'Given only the required parameters, it returns a token.' {
            Mock Invoke-WebRequest  -Verifiable  `
                -MockWith {return @{Content='530bf219-5360-41d3-81d1-8b4d6f75956d';StatusCode=200;}} `
                -ModuleName Securonix.CLI.Auth

            $token = New-SecuronixApiToken -Url $Url -Username 'jhalpert' -Password 'sEcUrEpAsSwOrD'

            Should -InvokeVerifiable
            $token | Should -not -BeNullOrEmpty
        }
        It 'Given a validity, it returns a token.' {
            Mock Invoke-WebRequest  -Verifiable  `
                -MockWith {return @{Content='530bf219-5360-41d3-81d1-8b4d6f75956d';StatusCode=200;}} `
                -ModuleName Securonix.CLI.Auth

            $token = New-SecuronixApiToken -Url $Url -Username 'jhalpert' -Password 'sEcUrEpAsSwOrD' -Validity 7

            Should -InvokeVerifiable
            $token | Should -not -BeNullOrEmpty
        }
        It 'Given only required positional parameters, it returns a token.' {
            Mock Invoke-WebRequest  -Verifiable  `
                -MockWith {return @{Content='530bf219-5360-41d3-81d1-8b4d6f75956d';StatusCode=200;}} `
                -ModuleName Securonix.CLI.Auth

            $token = New-SecuronixApiToken $Url 'jhalpert' 'sEcUrEpAsSwOrD' 7

            Should -InvokeVerifiable
            $token | Should -not -BeNullOrEmpty
        }
        It 'Given all positional parameters, it returns a token.' {
            Mock Invoke-WebRequest  -Verifiable  `
                -MockWith {return @{Content='530bf219-5360-41d3-81d1-8b4d6f75956d';StatusCode=200;}} `
                -ModuleName Securonix.CLI.Auth

            $token = New-SecuronixApiToken $Url 'jhalpert' 'sEcUrEpAsSwOrD'

            Should -InvokeVerifiable
            $token | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Confirm-SecuronixApiToken' {
    Context "When token is valid" {
        It 'Given the required parameters, it returns "Valid".' {
            Mock Invoke-WebRequest  -Verifiable `
                -MockWith {return @{Content='Valid';StatusCode=200;}} `
                -ModuleName Securonix.CLI.Auth
            $token = Confirm-SecuronixApiToken -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d'
            
            Should -InvokeVerifiable
            $token | Should -be 'Valid'
        }
        It 'Given the required positional parameters, it returns "Valid".' {
            Mock Invoke-WebRequest  -Verifiable `
                -MockWith {return @{Content='Valid';StatusCode=200;}} `
                -ModuleName Securonix.CLI.Auth
            $token = Confirm-SecuronixApiToken $Url '530bf219-5360-41d3-81d1-8b4d6f75956d'
            
            Should -InvokeVerifiable
            $token | Should -be 'Valid'
        }
    }
}

Describe 'Update-SecuronixApiToken' {
    Context "When token is valid" {
        It 'Given the required parameters, it returns "Success".' {
            Mock Invoke-WebRequest -Verifiable `
                -MockWith {return @{Content='Success';StatusCode=200;}} `
                -ModuleName Securonix.CLI.Auth

            $token = Update-SecuronixApiToken -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d'
            
            Should -InvokeVerifiable
            $token | Should -be 'Success'
        }
        It 'Given the required positional parameters, it returns "Success".' {
            Mock Invoke-WebRequest -Verifiable `
                -MockWith {return @{Content='Success';StatusCode=200;}} `
                -ModuleName Securonix.CLI.Auth

            $token = Update-SecuronixApiToken $Url '530bf219-5360-41d3-81d1-8b4d6f75956d'
            
            Should -InvokeVerifiable
            $token | Should -be 'Success'
        }
    }
}

AfterAll {
    Remove-Module Securonix.CLI
}