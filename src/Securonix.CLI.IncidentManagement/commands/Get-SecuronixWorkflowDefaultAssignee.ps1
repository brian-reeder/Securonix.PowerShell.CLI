<#
.DESCRIPTION
Get-SecuronixWorkflowDefaultAssignee makes an API call to the Incident/Get endpoint and retrieves the resource an incident will be assigned for the selected workflow.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WorkflowName
A required API Parameter, enter the name of a Securonix workflow.

.INPUTS
None. You cannot pipe objects to Get-SecuronixWorkflowDefaultAssignee

.OUTPUTS
System.String. Get-SecuronixWorkflowDefaultAssignee returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixWorkflowDefaultAssignee -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -WorkflowName SOCTeamReview

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixWorkflowDefaultAssignee.md
#>
function Get-SecuronixWorkflowDefaultAssignee {
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
			'WorkflowName' = 'workflow'
		}
		
		$params = [ordered]@{'type'='defaultAssignee'}
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