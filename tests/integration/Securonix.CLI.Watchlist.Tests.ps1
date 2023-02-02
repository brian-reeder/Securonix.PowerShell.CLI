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

    $WatchlistEntityId = $config.WatchlistEntityId
    $WatchlistName = $config.WatchlistName
}

Describe 'Add-SecuronixEntityToWatchlist' -Skip:($disable."Add-SecuronixEntityToWatchlist") {
    It 'Tests have not been implemented. See issue #94' {
        $null | Should -Not -BeNullOrEmpty
    }
}

Describe 'Get-SecuronixEntityWatchlistList' -Skip:($disable."Get-SecuronixEntityWatchlistList") {
    BeforeAll {
        $query = $config.query."Get-SecuronixEntityWatchlistList"
    }
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given required parameters, it returns a list of Watchlists.' {
            $response = Get-SecuronixEntityWatchlistList -Url $url -Token $token `
                -EntityId $WatchlistEntityId
        }
        It 'Given all parameters, it returns a list of Watchlists.' {
            $response = Get-SecuronixEntityWatchlistList -Url $url -Token $token `
                -EntityId $WatchlistEntityId -WatchlistName $WatchlistName
        }
        It 'Given positional parameters, it returns a list of Watchlists.' {
            $response = Get-SecuronixEntityWatchlistList $url $token `
                $WatchlistEntityId
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixWatchlistList' -Skip:($disable."Get-SecuronixWatchlistList") {
    BeforeAll {
        $query = $config.query."Get-SecuronixWatchlistList"
    }
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given required parameters, it returns a list of Watchlists.' {
            $response = Get-SecuronixWatchlistList -Url $url -Token $token
        }
        It 'Given positional parameters, it returns a list of Watchlists.' {
            $response = Get-SecuronixWatchlistList $url $token
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}


Describe 'Get-SecuronixWatchlistMemberList' -Skip:($disable."Get-SecuronixWatchlistMemberList") {
    BeforeAll {
        $query = $config.query."Get-SecuronixWatchlistMemberList"
    }
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given required parameters, it returns a list of entities.' {
            $response = Get-SecuronixWatchlistMemberList -Url $url -Token $token `
                -WatchlistName $WatchlistName
        }
        It 'Given positional parameters, it returns a list of entities.' {
            $response = Get-SecuronixWatchlistMemberList $url $token `
                $WatchlistName
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'New-SecuronixWatchlist' -Skip:($disable."New-SecuronixWatchlist") {
    It 'Tests have not been implemented. See issue #94' {
        $null | Should -Not -BeNullOrEmpty
    }
}

AfterAll {
    Remove-Module Securonix.CLI*
}