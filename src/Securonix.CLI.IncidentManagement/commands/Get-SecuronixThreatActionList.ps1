<#
.DESCRIPTION
Get-SecuronixThreatActionList makes an API call to the Incident/Get endpoint and retrieves all actions avaiable for an incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Get-SecuronixThreatActionList

.OUTPUTS
System.String. Get-SecuronixThreatActionList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixThreatActionList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixThreatActionList.md
#>
function Get-SecuronixThreatActionList {
	[CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
	[System.Diagnostics.CodeAnalysis.SuppressMessage('PSShouldProcess', '',
        Scope='Function',
        Justification='ShouldProcess is handled by the function Get-SecuronixIncidentAPIResponse'
    )]
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token
	)

	Begin {
		$Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
		}

		$params = [ordered]@{'type'='threatActions'}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
		$r = Get-SecuronixIncidentAPIResponse @Params
		return $r
	}

	End {}
}