# Invoke-Pester -Output Detailed .\Test\*.Tests.ps1
BeforeAll {
    Remove-Module Securonix.CLI -ErrorAction SilentlyContinue
    Import-Module $PSScriptRoot\..\Securonix.CLI.psd1

    $Url = 'https://dundermifflin.securonix.net/Snypr'

    $ResourceGroups = [xml]@'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?> <resourceGroups> <resourceGroup> <name>Bluecoat Proxy</name> <type>Bluecoat Proxy</type> </resourceGroup> <resourceGroup> <name>Ironport Data</name> <type>Cisco Ironport Email</type> </resourceGroup> <resourceGroup> <name>Windchill Data</name> <type>Windchill</type> </resourceGroup> </resourceGroups>
'@
    $PolicyList = [xml]@'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?> <policies> <policy> <createdBy>admin</createdBy> <createdOn>2013-11-09T16:13:23-06:00</createdOn> <criticality>Low</criticality> <description></description> <hql> FROM AccessAccount AS accessaccount, Resources AS resources, AccessAccountUser AS accessaccountuser WHERE ((accessaccount.resourceid = resources.id AND accessaccountuser.id.accountid = accessaccount.id )) AND ((accessaccountuser.id.userid = '-1'))</hql> <id>1</id> <name>Accounts that dont have Users</name> </policy> <policy> <createdBy>DocTeam</createdBy> <createdOn>2013-11-09T16:31:09-06:00</createdOn> <criticality>Medium</criticality> <description></description> <hql> FROM Users AS users, AccessAccountUser AS accessaccountuser, AccessAccount AS accessaccount, Resources AS resources WHERE ((users.id = accessaccountuser.id.userid AND accessaccountuser.id.accountid = accessaccount.id AND accessaccount.resourceid = resources.id )) AND ((users.status = '0'))</hql> <id>2</id> <name>Accounts that belong to terminated user</name> </policy> </policies>
'@
    $PeerGroupList = [xml]@'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><peerGroups><peerGroup> <criticality>Low</criticality><name>Advertising</name></peerGroup><peerGroup> <criticality>Low</criticality><name>Branding</name></peerGroup></peerGroups> 
'@
}

Describe 'Get-SecuronixResourcegroupList' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $ResourceGroups } `
                -ModuleName Securonix.CLI.List
        }
        It 'Given required parameters, it returns all resource groups.' {
            $response = Get-SecuronixResourcegroupList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'
            Should -InvokeVerifiable
            $response.Count | Should -be 3
        }
        It 'Given positional parameters, it returns all resource groups.' {
            $response = Get-SecuronixResourcegroupList 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF'
            Should -InvokeVerifiable
            $response.Count | Should -be 3
        }
    }
}

Describe 'Get-SecuronixPolicyList' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $PolicyList } `
                -ModuleName Securonix.CLI.List
        }
        It 'Given required parameters, it returns all configured policies.' {
            $response = Get-SecuronixPolicyList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'
            Should -InvokeVerifiable
            $response.Count | Should -be 2
        }
        It 'Given positional parameters, it returns all configured policies.' {
            $response = Get-SecuronixPolicyList 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF'
            Should -InvokeVerifiable
            $response.Count | Should -be 2
        }
    }
}

Describe 'Get-SecuronixPeerGroupsList' {
    Context "When token is valid" {
        BeforeEach {
            Mock Invoke-RestMethod -Verifiable `
                -MockWith { return $PeerGroupList } `
                -ModuleName Securonix.CLI.List
        }
        It 'Given required parameters, it returns all user peer groups.' {
            $response = Get-SecuronixPeerGroupsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'
            Should -InvokeVerifiable
            $response.Count | Should -be 2
        }
        It 'Given positional parameters, it returns all user peer groups.' {
            $response = Get-SecuronixPeerGroupsList 'DunderMifflin.securonix.com/Snypr' '12345678-90AB-CDEF-1234-567890ABCDEF'
            Should -InvokeVerifiable
            $response.Count | Should -be 2
        }
    }
}

AfterAll {
    Remove-Module Securonix.CLI
}