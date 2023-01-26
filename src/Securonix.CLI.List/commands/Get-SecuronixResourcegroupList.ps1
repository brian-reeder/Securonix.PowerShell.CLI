<#
.DESCRIPTION
Get-SecuronixResourcegroupList prepares API parameters and queries the Securonix for a list of all Resource Groups configured by Snypr for monitoring.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Get-SecuronixResourcegroupList

.OUTPUTS
System.String. Get-SecuronixResourcegroupList returns the API response. The API will respond with a XML object for valid requests.

.EXAMPLE
PS> Get-SecuronixResourcegroupList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/List/Get-SecuronixResourcegroupList.md
#>
function Get-SecuronixResourcegroupList {
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

        $Uri = "$Url/ws/list/resourceGroups"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response.resourceGroups.resourceGroup
        }
	}

	End {}
}