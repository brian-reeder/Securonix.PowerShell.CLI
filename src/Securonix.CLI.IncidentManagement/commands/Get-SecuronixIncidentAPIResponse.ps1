<#
.DESCRIPTION
Get-SecuronixIncidentAPIResponse is a flexible controller used to process Securonix Incident Management calls. Use the higher level interfaces to enforce parameter guidelines.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER type
A required API Parameter, enter the API type to view the details.

.PARAMETER incidentId
A required API Parameter, enter the unique incident id number.

.PARAMETER from
A required API Parameter, enter time starting point. Time (epoch) in ms.

.PARAMETER to
A required API Parameter, enter time ending point. Time (epoch) in ms.

.PARAMETER rangeType
A required API Parameter, enter the incident action status. Select any of updated,opened,closed.

.PARAMETER status
An optional API Parameter, filter results by status.

.PARAMETER allowChildCases
An optional API Parameter, used to receive the list of child cases associated with a parent case in the response.

.PARAMETER max
An optional API Parameter, enter maximum number of records the API will display.

.PARAMETER offset
An optional API Parameter, used for pagination of the request.

.PARAMETER workflowname
A required API Parameter, enter the name of a Securonix workflow.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentAPIResponse

.OUTPUTS
System.String. Get-SecuronixIncidentAPIResponse returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentAPIResponse -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -type "metaInfo" -incidentId "1234567890"

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixIncidentAPIResponse.md
#>
function Get-SecuronixIncidentAPIResponse {
	[CmdletBinding(
		DefaultParameterSetName='default',
		SupportsShouldProcess
	)]
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token,
		[Parameter(Mandatory)]
		[ValidateSet(
			'actionInfo','actions','activityStreamInfo',
			'childCaseInfo','defaultAssignee','list',
			'metaInfo','status','threatActions',
			'workflow','workflowDetails','workflowname',
			'workflows'
		)]
		[string] $type,

		[Parameter(ParameterSetName='incident',Mandatory)]
		[Parameter(ParameterSetName='actioninfo',Mandatory)]
		[string] $incidentId,
		[Parameter(ParameterSetName='list',Mandatory)]
		[string] $from,
		[Parameter(ParameterSetName='list',Mandatory)]
		[string] $to,
		[Parameter(ParameterSetName='list',Mandatory)]
		[string] $rangeType,
		[Parameter(ParameterSetName='list')]
		[string] $status,
		[Parameter(ParameterSetName='list')]
		[switch] $allowChildCases,
		[Parameter(ParameterSetName='list')]
		[int] $max,
		[Parameter(ParameterSetName='list')]
		[int] $offset,
		[Parameter(ParameterSetName='actioninfo',Mandatory)]
		[string] $actionName,
		[Parameter(ParameterSetName='workflowDetails', Mandatory)]
		[string] $workflowname,
		[Parameter(ParameterSetName='defaultAssignee', Mandatory)]
		[string] $workflow
	)

	Begin {
		if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

		$Exclusions = @('Url', 'Token', 'WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }
		
		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
			$paramsList += "$($param)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/get?$($paramsList -join '&')"
	}

	Process {
		if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
			$response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
			return $response.result
		}
	}

	End {}
}