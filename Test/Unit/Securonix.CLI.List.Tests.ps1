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

    $url   = 'https://dundermifflin.securonix.net/Snypr'
    $token = '530bf219-5360-41d3-81d1-8b4d6f75956d'
}

Describe 'Get-SecuronixResourcegroupList' {
    BeforeAll {
        $ValidResponse = [xml]@'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?> <resourceGroups> <resourceGroup> <name>Bluecoat Proxy</name> <type>Bluecoat Proxy</type> </resourceGroup> <resourceGroup> <name>Ironport Data</name> <type>Cisco Ironport Email</type> </resourceGroup> <resourceGroup> <name>Windchill Data</name> <type>Windchill</type> </resourceGroup> </resourceGroups>
'@
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.List
        }
        It 'Given required parameters, it returns all resource groups.' {
            $response = Get-SecuronixResourcegroupList -Url $url -Token $token
        }
        It 'Given positional parameters, it returns all resource groups.' {
            $response = Get-SecuronixResourcegroupList $url $token
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.Count | Should -be 3
        }
    }
    Context "When connection is set" {
        BeforeEach {
            $env:scnx_url   = $url
            $env:scnx_token = $token

            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.List
        }
        It 'Given no parameters, it returns all resource groups.' {
            $response = Get-SecuronixResourcegroupList
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.Count | Should -be 3
        }
        AfterAll {
            $env:scnx_url   = ''
            $env:scnx_token = ''
        }
    }
}

Describe 'Get-SecuronixPolicyList' {
    BeforeAll {
        $ValidResponse = [xml]@'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?> <policies> <policy> <createdBy>admin</createdBy> <createdOn>2013-11-09T16:13:23-06:00</createdOn> <criticality>Low</criticality> <description></description> <hql> FROM AccessAccount AS accessaccount, Resources AS resources, AccessAccountUser AS accessaccountuser WHERE ((accessaccount.resourceid = resources.id AND accessaccountuser.id.accountid = accessaccount.id )) AND ((accessaccountuser.id.userid = '-1'))</hql> <id>1</id> <name>Accounts that dont have Users</name> </policy> <policy> <createdBy>DocTeam</createdBy> <createdOn>2013-11-09T16:31:09-06:00</createdOn> <criticality>Medium</criticality> <description></description> <hql> FROM Users AS users, AccessAccountUser AS accessaccountuser, AccessAccount AS accessaccount, Resources AS resources WHERE ((users.id = accessaccountuser.id.userid AND accessaccountuser.id.accountid = accessaccount.id AND accessaccount.resourceid = resources.id )) AND ((users.status = '0'))</hql> <id>2</id> <name>Accounts that belong to terminated user</name> </policy> </policies>
'@
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.List
        }
        It 'Given required parameters, it returns all configured policies.' {
            $response = Get-SecuronixPolicyList -Url $url -Token $token
        }
        It 'Given positional parameters, it returns all configured policies.' {
            $response = Get-SecuronixPolicyList $url $token
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.Count | Should -be 2
        }
    }
    Context "When connection is set" {
        BeforeEach {
            $env:scnx_url   = $url
            $env:scnx_token = $token

            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.List
        }
        It 'Given no parameters, it returns all configured policies.' {
            $response = Get-SecuronixPolicyList
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.Count | Should -be 2
        }
        AfterAll {
            $env:scnx_url   = ''
            $env:scnx_token = ''
        }
    }
}

Describe 'Get-SecuronixPeerGroupsList' {
    BeforeAll {
        $ValidResponse = [xml]@'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><peerGroups><peerGroup> <criticality>Low</criticality><name>Advertising</name></peerGroup><peerGroup> <criticality>Low</criticality><name>Branding</name></peerGroup></peerGroups> 
'@
    }
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.List
        }
        It 'Given required parameters, it returns all user peer groups.' {
            $response = Get-SecuronixPeerGroupsList -Url $url -Token $token
        }
        It 'Given positional parameters, it returns all user peer groups.' {
            $response = Get-SecuronixPeerGroupsList $url $token
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.Count | Should -be 2
        }
    }
    Context "When connection is set" {
        BeforeEach {
            $env:scnx_url   = $url
            $env:scnx_token = $token

            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ValidResponse } `
                -ModuleName Securonix.CLI.List
        }
        It 'Given no parameters, it returns all user peer groups.' {
            $response = Get-SecuronixPeerGroupsList
        }
        AfterEach {
            Should -InvokeVerifiable
            $response.Count | Should -be 2
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