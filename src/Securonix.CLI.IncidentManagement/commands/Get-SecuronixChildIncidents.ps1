<#
.DESCRIPTION
Get-SecuronixChildIncidents makes an API call to the Incident/Get endpoint and retrieves all children incident ids of an incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER ParentId
A required API Parameter, enter the incident id to view the details.

.INPUTS
None. You cannot pipe objects to Get-SecuronixChildIncidents

.OUTPUTS
System.String. Get-SecuronixChildIncidents returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixChildIncidents -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -ParentId '100107'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixChildIncidents.md
#>
function Get-SecuronixChildIncidents {
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
		
		$params = [ordered]@{'type'='childCaseInfo'}
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