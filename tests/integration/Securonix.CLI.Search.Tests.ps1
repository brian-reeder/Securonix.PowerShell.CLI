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

    $timestart_epoch = $config.timestart.epoch
    $timeend_epoch   = $config.timeend30d.epoch

    $timestart_datetime = $config.timestart.datetime
    $timeend_datetime   = $config.timeend30d.datetime

}

Describe 'Get-SecuronixActivityEventsList' -Skip:($disable."Get-SecuronixActivityEventsList") {
    BeforeAll {
        $query = $config.query."Get-SecuronixActivityEventsList"
    }
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given datetime, it returns a list of events.' {
            $response = Get-SecuronixActivityEventsList -Url $url -Token $token `
                -TimeStart $timestart_datetime -TimeEnd $timeend_datetime `
                -Query $query -Max 10
        }
        It 'Given time epoch, it returns a list of events.' {
            $response = Get-SecuronixActivityEventsList -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch `
                -Query $query -Max 10
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixAssetData' -Skip:($disable."Get-SecuronixAssetData") {
    BeforeAll {
        $query = $config.query."Get-SecuronixAssetData"
    }
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixAssetData -Url $url -Token $token -Query $query
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixAssetData $url $token $query
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixGeolocationData' -Skip:($disable."Get-SecuronixGeolocationData") {
    BeforeAll {
        $query = $config.query."Get-SecuronixGeolocationData"
    }
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixGeolocationData -Url $url -Token $token -Query $query
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixGeolocationData $url $token $query
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixLookupData' -Skip:($disable."Get-SecuronixLookupData") {
    BeforeAll {
        $query = $config.query."Get-SecuronixLookupData"
    }
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixLookupData -Url $url -Token $token -Query $query
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixLookupData $url $token $query
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixRiskHistory' -Skip:($disable."Get-SecuronixRiskHistory") {
    It 'Tests have not been implemented. See issue #83' {
        $null | Should -Not -BeNullOrEmpty
    }
}

Describe 'Get-SecuronixRiskScorecard' -Skip:($disable."Get-SecuronixRiskScorecard") {
    It 'Tests have not been implemented. See issue #83' {
        $null | Should -Not -BeNullOrEmpty
    }
}

Describe 'Get-SecuronixTPI' -Skip:($disable."Get-SecuronixTPI") {
    BeforeAll {
        $query = $config.query."Get-SecuronixTPI"
    }
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixTPI -Url $url -Token $token -Query $query
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixTPI $url $token $query
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixUsersData' -Skip:($disable."Get-SecuronixUsersData") {
    BeforeAll {
        $query = $config.query."Get-SecuronixUsersData"
    }
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixUsersData -Url $url -Token $token -Query $query
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixUsersData $url $token $query
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixViolationEventsList' -Skip:($disable."Get-SecuronixViolationEventsList") {
    BeforeAll {
        $query = $config.query."Get-SecuronixViolationEventsList"
    }
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given datetime, it returns a list of events.' {
            $response = Get-SecuronixViolationEventsList -Url $url -Token $token `
                -TimeStart $timestart_datetime -TimeEnd $timeend_datetime `
                -Query $query -Max 10
        }
        It 'Given time epoch, it returns a list of events.' {
            $response = Get-SecuronixViolationEventsList -Url $url -Token $token `
                -TimeStart $timestart_epoch -TimeEnd $timeend_epoch `
                -Query $query -Max 10
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

Describe 'Get-SecuronixWatchlistData' -Skip:($disable."Get-SecuronixWatchlistData") {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{ "available": "false", "error": "false", "events": [{ "directImport": "false", "hour": "0", "ignored": "false", "invalid": "false", "invalidEventAction": "0", "tenantid": "1", "tenantname": "Securonix", "u_id": "-1", "u_userid": "-1", "result": {"entry": [ {"key": "reason","value": ""},{"key": "expirydate","value": "1540674976881"},{"key": "u_employeeid","value": "1002"},{"key": "u_department", "value": "Mainframe and Midrange Administration" },{"key": "u_workphone","value": "9728351246"},{"key": "u_division","value": "Global Technology"},{"key": "confidencefactor","value": "0.0"},{"key": "entityname","value": "1002"},{"key": "u_jobcode","value": "R1"},{"key": "u_hiredate","value": "1249707600000"},{"key": "type","value": "Users"},{"key": "u_costcentername","value": "IINFCCC12"},{"key": "expired","value": "false"},{"key": "u_employeetypedescription","value": "FullTime"},{"key": "tenantid","value": "2"},{"key": "u_status","value": "1"},{"key": "decayflag","value": "false"},{"key": "u_lanid","value": "HO1002"},{"key": "u_country","value": "USA"},{"key": "u_title","value": "Associate Mainframe Administrator"},{"key": "u_companycode","value": "TECH"},{"key": "watchlistuniquekey","value": "2^~Flight Risk Users|1002"},{"key": "u_lastname","value": "OGWAL"},{"key": "u_statusdescription","value": "Active"},{"key": "u_firstname","value": "HOMER"},{"key": "u_middlename","value": "B"},{"key": "u_masked","value": "false"},{"key": "u_employeetype","value": "FT"},{"key": "watchlistname","value": "Flight Risk Users"},{"key": "u_workemail","value": "HOMER.OGWAL@scnx.com"},{"key": "u_manageremployeeid","value": "1001"},{"key": "tenantname","value": "partnerdemo"},{"key": "u_location","value": "LOS ANGELES"}]}}],"from": "1533842667887", "offset": "1000", "query": "index=watchlist AND watchlistname=\"Flight Risk Users\"", "searchViolations": "false", "to": "1536521067887", "totalDocuments": "1" }'
        $query = $config.query."Get-SecuronixWatchlistData"
    }
    Context "When token is valid" {
        BeforeAll {
            $token = New-SecuronixApiToken -Url $url -Username $username `
                -Password $password -Validity 1
        }
        It 'Given all optional parameters, it returns a list of events.' {
            $response = Get-SecuronixWatchlistData -Url $url -Token $token -Query $query
        }
        It 'Given all positional parameters, it returns a list of events.' {
            $response = Get-SecuronixWatchlistData $url $token $query
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -not -BeNullOrEmpty
        }
    }
}

AfterAll {
    Remove-Module Securonix.CLI*
}