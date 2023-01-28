<#
.DESCRIPTION
Update-SecuronixApiToken makes an API call to the AUTH/Renew Securonix Web API to renew the supplied token. If the token was renewed, the API will respond with "Success".

.PARAMETER Url
Url endpoint for your Securonix instance.

.PARAMETER Token
An API token to renew. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Update-SecuronixApiToken

.OUTPUTS
System.String. Update-SecuronixApiToken returns the API response. The API will respond with "Success" for renewed API tokens.

.EXAMPLE
PS> Update-SecuronixApiToken -Url "hxxps://DunderMifflin.securonix.com" -Token "12345678-90AB-CDEF-1234-567890ABCDEF"

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Auth/Update-SecuronixApiToken.md
#>
function Update-SecuronixApiToken {
    [CmdletBinding(
        DefaultParameterSetName='default',
        PositionalBinding,
        SupportsShouldProcess
    )]
    param(
        [Parameter(ParameterSetName='supplied',
            Mandatory,
            Position=0
        )]
        [string] $Url,
        [Parameter(ParameterSetName='supplied',
            Mandatory,
            Position=1
        )]
        [string] $Token
    )

    Begin {
        $Url,$Token = Get-SecuronixConnection -ParameterSet $PSBoundParameters

        $Header = @{
            token = $Token
        }

        $Uri = "$Url/ws/token/renew"
    }

    Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -UseBasicParsing -Method Get
            return $response
        }

    }

    End {}
}