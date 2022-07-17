
<#
.DESCRIPTION
    AUTH/Generate Token
#>
function New-SecuronixApiToken {
    param(
        [Parameter(Mandatory)]
        [string] $Url,
        [Parameter(Mandatory)]
        [string] $Username,
        [Parameter(Mandatory)]
        [string] $Password,
        [int] $Validity=365
    )

    Begin {
        $r = Invoke-WebRequest -Uri $Url -DisableKeepAlive -UseBasicParsing -Method Head
        if($r.StatusCode -ge 400) {
            # TODO: Raise an error or exception
            # Server is not available
            break
        }

        $Header = @{
            username = $Username
            password = $Password
            validity = $Validity
        }

        $Uri = "$Url/ws/token/generate"
        break
    }

    Process {
        return (Invoke-WebRequest -Uri $Uri -Headers $Header -UseBasicParsing -Method Get).Content

    }
}

<#
.DESCRIPTION
    AUTH/Validate Token
#>
function Confirm-SecuronixApiToken {
    param(
        [Parameter(Mandatory)]
        [string] $Url,
        [Parameter(Mandatory)]
        [string] $Token
    )

    Begin {
        $Header = @{
            token = $Token
        }

        $Uri = "$Url/ws/token/validate"
    }

    Process {
        Write-Output "TODO: Validate Token!"
        Write-Output $Uri
        Write-Output $Header
    }

    End {}
}

<#
.DESCRIPTION
    AUTH/Renew Token
#>
function Update-SecuronixApiToken {
    param(
        [Parameter(Mandatory)]
        [string] $Url,
        [Parameter(Mandatory)]
        [string] $Token
    )

    Begin {
        $Header = @{
            token = $Token
        }

        $Uri = "$Url/ws/token/renew"
    }

    Process {
        Write-Output "TODO: Renew Token!"
        Write-Output $Uri
        Write-Output $Header
        
    }

    End {}
}

Export-ModuleMember -Function New-SecuronixApiToken
Export-ModuleMember -Function Confirm-SecuronixApiToken
Export-ModuleMember -Function Update-SecuronixApiToken