function Test-NewTokenApi {
    param ()
    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing New-SecuronixApiToken'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Username = $ScnxParams.Username
            Password = $ScnxParams.Password
            Validity = 1
        }
        New-SecuronixApiToken @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-ConfirmTokenApi {
    param ()
    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Confirm-SecuronixApiToken'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
        }
        Confirm-SecuronixApiToken @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-UpdateTokenApi {
    param ()
    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Update-SecuronixApiToken'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
        }
        Update-SecuronixApiToken @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

Test-NewTokenApi
Test-ConfirmTokenApi
Test-UpdateTokenApi