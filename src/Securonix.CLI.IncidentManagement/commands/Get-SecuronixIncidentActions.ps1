<#
.DESCRIPTION
Get-SecuronixIncidentActions makes an API call to the incident/Get endpoint and retrieves the actions available for an incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view available actions.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentActions

.OUTPUTS
System.String. Get-SecuronixIncidentActions returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentActions -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -IncidentId 1234567890

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixIncidentActions.md
#>
function Get-SecuronixIncidentActions {
	[CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token,
		[Parameter(Mandatory)]
		[string] $IncidentId
	)

	Begin {
		$paramsTable = @{
			'IncidentId' = 'incidentId'
		}
		
		$params = [ordered]@{'type'='actions'}
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