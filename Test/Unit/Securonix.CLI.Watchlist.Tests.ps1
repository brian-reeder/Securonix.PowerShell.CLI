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

    $Url = 'https://dundermifflin.securonix.net/Snypr'

    $WatchlistList = ConvertFrom-Json '{"status": "OK","messages": ["Get all existing watchlists."],"result": {"Domain_Admin": "0","Flight_Risk_Users_Watchlist":"0","Recent_Transfers": "0","Exiting_Behavior_Watchlist": "0","Test_watchlist2": "0","Bad_Performance_Review": "0","Terminated_Contractors": "0","Contractors-UpComing_Termination": "0","Privileged_Accounts": "0","Terminated_Employees": "0","Test_watchlist": "2","Privileged_Users": "0","Recent_Hires": "0","Employees-UpComing_Terminations": "0"}}'
    $EntityWatchlist = ConvertFrom-Json '{"status": "OK","messages": ["The entityId provided is a part of these watchlists :"],"result": ["test_watchlist","Recently_Phished"]}'
    $WatchlistMembers = ConvertFrom-Json '{"status": "OK","messages": ["List of entities in the provided watchlist.","Type : Users","watchlistname : Test_watchlist","Count : 2"],"result": {"1002": "Users","1001": "Users"}}'
}

Describe 'New-SecuronixWatchlist' {
    Context "When token is valid" {
        It 'Given the required parameters, it returns a confirmation.' {
            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith {return @{Content='New watchlist created successfully..!';StatusCode=200;}} `
                -ModuleName Securonix.CLI.Watchlist

            $token = New-SecuronixWatchlist -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d' -WatchlistName 'test_watchlist'

            Should -InvokeVerifiable
            $token | Should -not -BeNullOrEmpty
        }
        It 'Given required positional parameters, it returns a confirmation.' {
            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith {return @{Content='New watchlist created successfully..!';StatusCode=200;}} `
                -ModuleName Securonix.CLI.Watchlist

            $token = New-SecuronixWatchlist $Url '530bf219-5360-41d3-81d1-8b4d6f75956d' 'test_watchlist'

            Should -InvokeVerifiable
            $token | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixWatchlistList' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith { return $WatchlistList } `
                -ModuleName Securonix.CLI.Watchlist
        }
        It 'Given the required parameters, it returns a list of watchlists.' {
            $response = Get-SecuronixWatchlistList -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d'

            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
        It 'Given the required positional parameters, it returns a list of watchlists.' {
            $response = Get-SecuronixWatchlistList $Url '530bf219-5360-41d3-81d1-8b4d6f75956d'

            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
    }
}

Describe 'Get-SecuronixEntityWatchlists' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith { return $EntityWatchlist } `
                -ModuleName Securonix.CLI.Watchlist
        }
        It 'Given the required parameters, it returns a list of watchlists.' {
            $response = Get-SecuronixEntityWatchlists -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d' -EntityId 'jhalpert'

            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
        It 'Given a watchlist name, it returns a list of watchlists.' {
            $response = Get-SecuronixEntityWatchlists -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d' -EntityId 'jhalpert' -WatchlistName 'test_watchlist'

            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
        It 'Given the required positional parameters, it returns a list of watchlists.' {
            $response = Get-SecuronixEntityWatchlists $Url '530bf219-5360-41d3-81d1-8b4d6f75956d' 'jhalpert'

            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
        It 'Given a watchlist name and positional parameters, it returns a list of watchlists.' {
            $response = Get-SecuronixEntityWatchlists $Url '530bf219-5360-41d3-81d1-8b4d6f75956d' 'jhalpert' 'test_watchlist'

            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
    }
}

Describe 'Add-SecuronixEntityToWatchlist' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith { return 'Add to watchlist successful..!' } `
                -ModuleName Securonix.CLI.Watchlist
        }
        It 'Given the user parameters, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d' -WatchlistName 'Phished Users' -UsersId 'jhalpert' -ExpiryDays 1

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given the user id and positional parameters, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist $Url '530bf219-5360-41d3-81d1-8b4d6f75956d' 'Phished Users' -UsersId 'jhalpert' -ExpiryDays 1

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given a list of users, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d' -WatchlistName 'Phished Users' -UsersIdList @('jhalpert','dshrute','mscott') -ExpiryDays 1

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given a list of users and positional parameters, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist $Url '530bf219-5360-41d3-81d1-8b4d6f75956d' 'Phished Users' -UsersIdList @('jhalpert','dshrute','mscott') -ExpiryDays 1

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given the activityaccount parameters, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d' -WatchlistName 'Phished Users' -ActivityaccountId 'jhalpert' -ExpiryDays 1 -ResourceGroupId '35'

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given the activityaccount id and positional parameters, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist $Url '530bf219-5360-41d3-81d1-8b4d6f75956d' 'Phished Users' -ActivityaccountId 'jhalpert' -ExpiryDays 1 -ResourceGroupId '35'

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given a list of activityaccounts, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d' -WatchlistName 'Phished Users' -ActivityaccountIdList @('jhalpert','dshrute','mscott') -ExpiryDays 1 -ResourceGroupId '35'

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given a list of activityaccounts and positional parameters, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist $Url '530bf219-5360-41d3-81d1-8b4d6f75956d' 'Phished Users' -ActivityaccountIdList @('jhalpert','dshrute','mscott') -ExpiryDays 1 -ResourceGroupId '35'

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given the resource id parameters, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d' -WatchlistName 'test_watchlist' -ResourceId 'DESKTOP' -ExpiryDays 1 -ResourceGroupId '35'

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given the resource id and positional parameters, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist $Url '530bf219-5360-41d3-81d1-8b4d6f75956d' 'test_watchlist' -ResourceId 'DESKTOP' -ExpiryDays 1 -ResourceGroupId '35'

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given a list of resource ids, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d' -WatchlistName 'test_watchlist' -ResourceIdList @('DESKTOP','LAPTOP','SERVER') -ExpiryDays 1 -ResourceGroupId '35'

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given a list of resource ids and positional parameters, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist $Url '530bf219-5360-41d3-81d1-8b4d6f75956d' 'test_watchlist' -ResourceIdList @('DESKTOP','LAPTOP','SERVER') -ExpiryDays 1 -ResourceGroupId '35'

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given the activity ip parameters, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d' -WatchlistName 'test_watchlist' -ActivityIpId '192.168.1.1' -ExpiryDays 1 -ResourceGroupId '35'

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given the activity ip and positional parameters, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist $Url '530bf219-5360-41d3-81d1-8b4d6f75956d' 'test_watchlist' -ActivityIpId '192.168.1.1' -ExpiryDays 1 -ResourceGroupId '35'

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given a list of activity ips, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d' -WatchlistName 'test_watchlist' -ActivityIpIdList @('192.168.1.1','192.168.2.2','192.168.3.3') -ExpiryDays 1 -ResourceGroupId '35'

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
        It 'Given a list of activity ips and positional parameters, it returns a confirmation.' {
            $response = Add-SecuronixEntityToWatchlist $Url '530bf219-5360-41d3-81d1-8b4d6f75956d' 'test_watchlist' -ActivityIpIdList @('192.168.1.1','192.168.2.2','192.168.3.3') -ExpiryDays 1 -ResourceGroupId '35'

            Should -InvokeVerifiable
            $response | Should -Be 'Add to watchlist successful..!'
        }
    }
}

Describe 'Get-SecuronixWatchlistMembers' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod  -Verifiable  `
                -MockWith { return $WatchlistMembers } `
                -ModuleName Securonix.CLI.Watchlist
        }
        It 'Given the required parameters, it returns a list of watchlists.' {
            $response = Get-SecuronixWatchlistMembers -Url $Url -Token '530bf219-5360-41d3-81d1-8b4d6f75956d' -WatchlistName 'test_watchlist'

            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
        It 'Given the required positional parameters, it returns a list of watchlists.' {
            $response = Get-SecuronixWatchlistMembers $Url '530bf219-5360-41d3-81d1-8b4d6f75956d' 'test_watchlist'

            Should -InvokeVerifiable
            $response.status | Should -Be 'OK'
        }
    }
}

AfterAll {
    Remove-Module Securonix.CLI
}