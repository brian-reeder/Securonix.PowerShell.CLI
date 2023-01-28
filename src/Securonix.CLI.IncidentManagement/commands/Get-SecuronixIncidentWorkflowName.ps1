<#
.DESCRIPTION
Get-SecuronixIncidentWorkflowName makes an API call to the Incident/Get endpoint and retrieves the workflow name of an incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the workflow name.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentWorkflowName

.OUTPUTS
System.String. Get-SecuronixIncidentWorkflowName returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentWorkflowName -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '100107'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixIncidentWorkflowName.md
#>
function Get-SecuronixIncidentWorkflowName {
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
		[string] $Token,
		[Parameter(Mandatory)]
		[string] $IncidentId
	)

	Begin {
		$paramsTable = @{
			'IncidentId' = 'incidentId'
		}

		$params = [ordered]@{'type'='workflow'}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
		$r = Get-SecuronixIncidentAPIResponse @Params
		return $r.workflow
	}

	End {}
}