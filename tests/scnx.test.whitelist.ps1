function Test-NewSecuronixWhitelist {
    param ()

    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing New-SecuronixWhitelist'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            WhiteListName = $ScnxParams.WhitelistName
            TenantName = $ScnxParams.TenantName
            EntityType = 'Users'
        }
        New-SecuronixWhitelist @params
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            WhiteListName = $ScnxParams.WhitelistName
            TenantName = $ScnxParams.TenantName
            EntityType = 'ActivityAccount'
        }
        New-SecuronixWhitelist @params
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            WhiteListName = $ScnxParams.WhitelistName
            TenantName = $ScnxParams.TenantName
            EntityType = 'Resources'
        }
        New-SecuronixWhitelist @params
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            WhiteListName = $ScnxParams.WhitelistName
            TenantName = $ScnxParams.TenantName
            EntityType = 'IpAddress'
        }
        New-SecuronixWhitelist @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-AddSecuronixAttributeToWhitelist {
    param ()
    
    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Add-SecuronixAttributeToWhitelist'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            WhiteListName = $ScnxParams.WhitelistName
            ViolationType = 'Policy'
            TenantName = $ScnxParams.TenantName
            SourceIp = '10.0.0.1'
            ExpiryDate = '01/02/2023'
        }        
        Add-SecuronixAttributeToWhitelist @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-AddSecuronixEntityToWhitelist {
    param ()
    
    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Add-SecuronixEntityToWhitelist'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            WhiteListName = $ScnxParams.WhitelistName
            TenantName = $ScnxParams.TenantName
            ActivityaccountEntityId = $ScnxParams.EmployeeId
            ResourceName = $ScnxParams.ResourceName
            ResourceGroupId = $ScnxParams.ResourceGroupId
        }        
        Add-SecuronixEntityToWhitelist @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-GetSecuronixWhitelist {
    param ()
    
    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Get-SecuronixWhitelist'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            WhiteListName = $ScnxParams.WhitelistName
            TenantName = $ScnxParams.TenantName
        }        
        Get-SecuronixWhitelist @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-GetSecuronixWhitelistMembers {
    param ()
    
    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Get-SecuronixWhitelistMembers'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            WhiteListName = $ScnxParams.WhitelistName
            TenantName = $ScnxParams.TenantName
        }        
        Get-SecuronixWhitelistMembers @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-RemoveSecuronixAttributeFromWhitelist {
    param ()
    
    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Remove-SecuronixAttributeFromWhitelist'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            WhiteListName = $ScnxParams.WhitelistName
            TenantName = $ScnxParams.TenantName
            AttributeName = 'source ip'
            AttributeValue = '10.0.0.1'
        }        
        Remove-SecuronixAttributeFromWhitelist @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-RemoveSecuronixEntityFromWhitelist {
    param ()
    
    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Remove-SecuronixEntityFromWhitelist'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            WhiteListName = $ScnxParams.WhitelistName
            TenantName = $ScnxParams.TenantName
            EntityId = $ScnxParams.EmployeeId
        }        
        Remove-SecuronixEntityFromWhitelist @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}


Test-NewSecuronixWhitelist
Test-AddSecuronixAttributeToWhitelist
Test-AddSecuronixEntityToWhitelist
Test-GetSecuronixWhitelist
Test-GetSecuronixWhitelistMembers
Test-RemoveSecuronixAttributeFromWhitelist
Test-RemoveSecuronixEntityFromWhitelist