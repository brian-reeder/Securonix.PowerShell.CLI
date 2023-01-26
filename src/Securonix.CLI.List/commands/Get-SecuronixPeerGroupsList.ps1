<#
.DESCRIPTION
Get-SecuronixPeerGroupsList prepares API parameters and queries the Securonix for a list of all Peer Groups configured by Snypr for monitoring.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Get-SecuronixPeerGroupsList

.OUTPUTS
System.String. Get-SecuronixPeerGroupsList returns the API response. The API will respond with a XML object for valid requests.

.EXAMPLE
PS> Get-SecuronixPeerGroupsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/List/Get-SecuronixPeerGroupsList.md
#>
function Get-SecuronixPeerGroupsList {
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
            'token' = $Token
        }

        $Uri = "$Url/ws/list/peerGroups"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response.peerGroups.peerGroup
        }
	}

	End {}
}