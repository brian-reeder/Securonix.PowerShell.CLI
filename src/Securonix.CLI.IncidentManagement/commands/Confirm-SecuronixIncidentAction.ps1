<#
.DESCRIPTION
Confirm-SecuronixIncidentAction makes an API call to the Incident/Get endpoint and checks to see if an actions is possible, and returns with a list of parameters.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the details.

.PARAMETER Actioname
A required API Parameter, check to see if this action is available for an incident.

.INPUTS
None. You cannot pipe objects to Confirm-SecuronixIncidentAction

.OUTPUTS
System.String. Confirm-SecuronixIncidentAction returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Confirm-SecuronixIncidentAction -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '100107' -ActionName 'Claim'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Confirm-SecuronixIncidentAction.md
#>
function Confirm-SecuronixIncidentAction {
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
		[string] $IncidentId,
		[Parameter(Mandatory)]
		[string] $ActionName
	)

	Begin {
		$paramsTable = @{
			'IncidentId' = 'incidentId'
			'ActionName' = 'actionName'
		}
		
		$params = [ordered]@{'type'='actionInfo'}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
		$r = Get-SecuronixIncidentAPIResponse @params
		return $r
	}

	End {}
}