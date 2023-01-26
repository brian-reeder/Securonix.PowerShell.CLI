<#
.DESCRIPTION
Get-SecuronixWorkflowDetails makes an API call to the Incident/Get endpoint and returns with the details for the specified workflow.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WorkflowName
A required API Parameter, enter the name of a Securonix workflow.

.INPUTS
None. You cannot pipe objects to Get-SecuronixWorkflowDetails

.OUTPUTS
System.String. Get-SecuronixWorkflowDetails returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
Get-SecuronixWorkflowDetails -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WorkflowName 'SOCTeamReview'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixWorkflowDetails.md
#>
function Get-SecuronixWorkflowDetails {
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
		[string] $WorkflowName
	)

	Begin {
		$paramsTable = @{
			'WorkflowName' = 'workflowname'
		}
		
		$params = [ordered]@{'type'='workflowDetails'}
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