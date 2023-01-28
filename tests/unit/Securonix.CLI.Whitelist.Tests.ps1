# Invoke-Pester -Output Detailed .\Test\*.Tests.ps1
[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessage(
    'PSUseDeclaredVarsMoreThanAssignments', '',
    Justification='PSSA does not properly detect for Pester scripts'
)]
Param()

$EntityTypes = @('Users', 'Activityaccount', 'Resources', 'IpAddress')

BeforeAll {
    $modulepath = "$PSScriptRoot\..\..\src\Securonix.CLI\Securonix.CLI.psd1"

    Remove-Module Securonix.CLI* -ErrorAction SilentlyContinue
    Import-Module $modulepath

    $url   = 'https://dundermifflin.securonix.net/Snypr'
    $token = '12345678-90AB-CDEF-1234-567890ABCDEF'
}

Describe 'Add-SecuronixAttributeToWhitelist' {
    BeforeAll {
        $ValidResponse = 'Data added to whitelist successfully...!'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Whitelist
        }
        It 'Given only policy parameters, it returns confirmation.' {
            $response = Add-SecuronixAttributeToWhitelist -Url $url -Token $token `
                -WhitelistName 'test_policyname' -TenantName 'PA-Scranton' `
                -ViolationType 'Policy' -AttributeName 'source ip' `
                -AttributeValue '127.0.0.1'
        }
        It 'Given only ThreatModel parameters, it returns confirmation.' {
            $response = Add-SecuronixAttributeToWhitelist -Url $url -Token $token `
                -WhitelistName 'test_threatmodel' -TenantName 'PA-Scranton' `
                -ViolationType 'ThreatModel' -AttributeName 'source ip' `
                -AttributeValue '127.0.0.1'
        }
        It 'Given only Functionality parameters, it returns confirmation.' {
            $response = Add-SecuronixAttributeToWhitelist -Url $url -Token $token `
                -WhitelistName 'Web Proxy' -TenantName 'PA-Scranton' `
                -ViolationType 'Functionality' -AttributeName 'source ip' `
                -AttributeValue '127.0.0.1'
        }
        It 'Given optional parameters, it returns confirmation.' {
            $response = Add-SecuronixAttributeToWhitelist -Url $url -Token $token `
                -WhitelistName 'test_policyname' -TenantName 'PA-Scranton' `
                -ViolationType 'Policy' -AttributeName 'source ip' `
                -AttributeValue '127.0.0.1' -ExpiryDate '01/02/2023'
        }
        It 'Given positional parameters, it returns confirmation.' {
            $response = Add-SecuronixAttributeToWhitelist $url $token `
                'test_policyname' 'PA-Scranton' `
                'Policy' 'source ip' `
                '127.0.0.1'
        }
        It 'Given only source ip parameters, it returns confirmation.' {
            $response = Add-SecuronixAttributeToWhitelist -Url $url -Token $token `
                -WhitelistName 'test_policyname' -TenantName 'PA-Scranton' `
                -ViolationType 'Policy' -SourceIp '127.0.0.1'
        }
        It 'Given only resourcetype parameters, it returns confirmation.' {
            $response = Add-SecuronixAttributeToWhitelist -Url $url -Token $token `
                -WhitelistName 'test_policyname' -TenantName 'PA-Scranton' `
                -ViolationType 'Policy' -ResourceType 'test_resourcetype'
        }
        It 'Given only transactionstring parameters, it returns confirmation.' {
            $response = Add-SecuronixAttributeToWhitelist -Url $url -Token $token `
                -WhitelistName 'test_policyname' -TenantName 'PA-Scranton' `
                -ViolationType 'Policy' -TransactionString 'test_transactionstring'
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -Be $ValidResponse
        }
    }
}

Describe 'Add-SecuronixEntityToWhitelist' {
    BeforeAll {
        $ValidResponse = 'Data added to whitelist successfully...!'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Whitelist
        }
        It 'Given only required parameters, it returns confirmation.' {
            $response = Add-SecuronixEntityToWhitelist -Url $url -Token $token `
                -WhitelistName 'remote_users' -TenantName 'PA-Scranton' `
                -EntityType 'Users' -EntityId 'jhalpert' `
                -ResourceName 'msft365_azuread' -ResourceGroupId '35'
        }
        It 'Given optional parameters, it returns confirmation.' {
            $response = Add-SecuronixEntityToWhitelist -Url $url -Token $token `
                -WhitelistName 'remote_users' -TenantName 'PA-Scranton' `
                -EntityType 'Users' -EntityId 'jhalpert' `
                -ResourceName 'dundermifflin_msft365_azuread' -ResourceGroupId '35' `
                -ExpiryDate '01/02/2023'
        }
        It 'Given positional parameters, it returns confirmation.' {
            $response = Add-SecuronixEntityToWhitelist $url $token `
                'remote_users' 'PA-Scranton' `
                'Users' 'jhalpert' `
                -ResourceName 'msft365_azuread' -ResourceGroupId '35'
        }
        It 'Given UsersEntityId parameters, it returns confirmation.' {
            $response = Add-SecuronixEntityToWhitelist -Url $url -Token $token `
                -WhitelistName 'remote_users' -TenantName 'PA-Scranton' `
                -UsersEntityId 'jhalpert'
        }
        It 'Given ActivityaccountEntityId parameters, it returns confirmation.' {
            $response = Add-SecuronixEntityToWhitelist -Url $url -Token $token `
                -WhitelistName 'remote_users' -TenantName 'PA-Scranton' `
                -ActivityaccountEntityId 'jhalpert' `
                -ResourceName 'msft365_azuread' -ResourceGroupId '35'
        }
        It 'Given ActivityipEntityId parameters, it returns confirmation.' {
            $response = Add-SecuronixEntityToWhitelist -Url $url -Token $token `
                -WhitelistName 'remote_users' -TenantName 'PA-Scranton' `
                -ActivityipEntityId '127.0.0.1'
        }
        It 'Given ResourcesEntityId parameters, it returns confirmation.' {
            $response = Add-SecuronixEntityToWhitelist -Url $url -Token $token `
                -WhitelistName 'remote_users' -TenantName 'PA-Scranton' `
                -ResourcesEntityId 'DESKTOP-TEST'
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -Be $ValidResponse
        }
    }
}

Describe 'Get-SecuronixWhitelist' {
    BeforeAll {
        $ValidResponse = ConvertFrom-Json '{"status": "OK","messages": [" WhiteList Name | Whitelist Type | Tenant Name "],"result": [" Whitelistname1 | whitelisttype1 | tenantname1 "," Whitelistname2 | whitelisttype2 | tenantname2 "," Whitelistname3 | whitelisttype3 | tenantname3 "," Whitelistname4 | whitelisttype4 | tenantname4 ",  ]}'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Whitelist
        }
        It 'Given only required parameters, it returns a list of whitelists.' {
            $response = Get-SecuronixWhitelist -Url $url -Token $token `
                -WhitelistName 'remote_users' -TenantName 'PA-Scranton'
        }
        It 'Given positional parameters, it returns a list of whitelists.' {
            $response = Get-SecuronixWhitelist $url $token `
                'remote_users' 'PA-Scranton'
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.count | Should -Be 4
        }
    }
}

Describe 'Get-SecuronixWhitelistMemberList' {
    BeforeAll {
        $ValidResponse = 'Test'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Whitelist
        }
        It 'Given only required parameters, it returns a list of whitelists.' {
            $response = Get-SecuronixWhitelistMemberList -Url $url -Token $token `
                -WhitelistName 'remote_users' -TenantName 'PA-Scranton'
        }
        It 'Given positional parameters, it returns a list of whitelists.' {
            $response = Get-SecuronixWhitelistMemberList $url $token `
                'remote_users' 'PA-Scranton'
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -Not -BeNullOrEmpty
        }
    }
}

Describe 'New-SecuronixWhitelist' {
    BeforeAll {
        $ValidResponse = 'New Global whitelist created successfully..!'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Whitelist
        }
        It 'Given <_> parameters, it returns a confirmation.' -ForEach $EntityTypes {
            $response = New-SecuronixWhitelist -Url $url -Token $token `
                -WhitelistName 'remote_users' -TenantName 'PA-Scranton' `
                -EntityType $_
        }
        It 'Given <_> positional parameters, it returns a confirmation.' -ForEach $EntityTypes {
            $response = New-SecuronixWhitelist $url $token `
                'remote_users' 'PA-Scranton' $_
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -Be $ValidResponse
        }
    }
}

Describe 'Remove-SecuronixAttributeFromWhitelist' {
    BeforeAll {
        $ValidResponse = 'Entity removed from whitelist Successfully ..!'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Whitelist
        }
        It 'Given parameters, it returns a confirmation.' {
            $response = Remove-SecuronixAttributeFromWhitelist -Url $url -Token $token `
            -WhitelistName 'remote_users' -TenantName 'PA-Scranton' `
            -AttributeName 'accountname' -AttributeValue 'jhalpert'
        }
        It 'Given positional parameters, it returns a confirmation.' {
            $response = Remove-SecuronixAttributeFromWhitelist $url $token `
            'remote_users' 'PA-Scranton' `
            'accountname' 'jhalpert'
        }
        It 'Given list parameters, it returns a confirmation.' {
            $response = Remove-SecuronixAttributeFromWhitelist -Url $url -Token $token `
            -WhitelistName 'remote_users' -TenantName 'PA-Scranton' `
            -AttributeName 'accountname' -AttributeValueList @('jhalpert','dshrute','mscott')
        }
        It 'Given positional list parameters, it returns a confirmation.' {
            $response = Remove-SecuronixAttributeFromWhitelist $url $token `
            'remote_users' 'PA-Scranton' `
            'accountname' @('jhalpert','dshrute','mscott')
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -Be $ValidResponse
        }
    }
}

Describe 'Remove-SecuronixEntityFromWhitelist' {
    BeforeAll {
        $ValidResponse = 'Entity removed from whitelist Successfully ..!'
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.Whitelist
        }
        It 'Given parameters, it returns a confirmation.' {
            $response = Remove-SecuronixEntityFromWhitelist -Url $url -Token $token `
            -WhitelistName 'remote_users' -TenantName 'PA-Scranton' `
            -EntityId 'jhalpert'
        }
        It 'Given positional parameters, it returns a confirmation.' {
            $response = Remove-SecuronixEntityFromWhitelist $url $token `
            'remote_users' 'PA-Scranton' `
            'jhalpert'
        }
        It 'Given list parameters, it returns a confirmation.' {
            $response = Remove-SecuronixEntityFromWhitelist -Url $url -Token $token `
            -WhitelistName 'datacenter_ips' -TenantName 'NY-New_York_City' `
            -EntityIdList @('192.168.0.1','172.16.0.1','10.0.0.1','127.0.0.1')
        }
        It 'Given positional list parameters, it returns a confirmation.' {
            $response = Remove-SecuronixEntityFromWhitelist $url $token `
            'datacenter_ips' 'NY-New_York_City' `
            @('192.168.0.1','172.16.0.1','10.0.0.1','127.0.0.1')
        }
        AfterEach {
            Should -InvokeVerifiable
            $response | Should -Be $ValidResponse
        }
    }
}

AfterAll {
    Remove-Module Securonix.CLI*
}