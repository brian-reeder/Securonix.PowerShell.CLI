<#
.DESCRIPTION
Confirm-SecuronixApiToken makes an API call to the AUTH/Validate Securonix Web API with the supplied token. If the token is valid, the API will respond with "Valid".

.PARAMETER Url
Url endpoint for your Securonix instance.

.PARAMETER Token
An API token to test. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Confirm-SecuronixApiToken

.OUTPUTS
System.String. Confirm-SecuronixApiToken returns the API response. The API will respond with "Valid" for valid API tokens.

.EXAMPLE
PS> Confirm-SecuronixApiToken -Url "hxxps://DunderMifflin.securonix.com" -Token "12345678-90AB-CDEF-1234-567890ABCDEF"

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Auth/Confirm-SecuronixApiToken.md
#>
function Confirm-SecuronixApiToken {
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

        $Uri = "$Url/ws/token/validate"
    }

    Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -UseBasicParsing -Method Get
            return $response
        }
    }

    End {}
}