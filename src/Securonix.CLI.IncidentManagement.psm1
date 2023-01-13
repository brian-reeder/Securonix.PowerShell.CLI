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
			'metaInfo','status','workflows',
			'actions', 'actionInfo','workflowname',
			'defaultAssignee','list','childCaseInfo',
			'activityStreamInfo', 'workflow','threatActions'
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
		[string] $workflowname
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

<#
.DESCRIPTION
Get-SecuronixIncident makes an API call to the Incident/Get endpoint and retrieves all details of an incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the details.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncident

.OUTPUTS
System.String. Get-SecuronixIncident returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncident -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '1234567890'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixIncident.md
#>
function Get-SecuronixIncident {
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
		
		$params = [ordered]@{'type'='metaInfo'}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
		$r = Get-SecuronixIncidentAPIResponse @params
		return $r.data.incidentItems
	}

	End {}
}

<#
.DESCRIPTION
Get-SecuronixIncidentStatus makes an API call to the Incident/Get endpoint and retrieves the status of an incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the status.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentStatus

.OUTPUTS
System.String. Get-SecuronixIncidentStatus returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentStatus -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '100107'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixIncidentStatus.md
#>
function Get-SecuronixIncidentStatus {
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
		
		$params = [ordered]@{'type'='status'}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
		$r = Get-SecuronixIncidentAPIResponse @params
		return $r.status
	}

	End {}
}

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
		return $r
	}

	End {}
}

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

<#
.DESCRIPTION
Get-SecuronixWorkflowsList makes an API call to the Incident/Get endpoint and retrieves the list of available Workflows for Incidents.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Get-SecuronixWorkflowsList

.OUTPUTS
System.String. Get-SecuronixWorkflowsList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixWorkflowsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixWorkflowsList.md
#>
function Get-SecuronixWorkflowsList {
	[CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token
	)

	Begin {}

	Process {
		$r = Get-SecuronixIncidentAPIResponse -Url $Url -Token $Token -type 'workflows' 
		return $r
	}

	End {}
}

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
		
		$params = [ordered]@{'type'='workflow'}
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
			'WorkflowName' = 'workflowName'
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

<#
.DESCRIPTION
Get-SecuronixIncidentsList makes an API call to the Incident/Get endpoint and retrieves a list of incidents opened within the supplied time range.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER TimeStart
A required API Parameter, enter starting point for the search. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS-00'.

.PARAMETER TimeEnd
A required API Parameter, enter ending point for the search. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS-00'.

.PARAMETER RangeType
A required API Parameter, select any of updated|opened|closed.

.PARAMETER Status
An optional API Parameter, filter results by status.

.PARAMETER AllowChildCases
An optional API Parameter, enter true to receive the list of child cases associated with a parent case in the response. Otherwise, enter false. This parameter is optional.

.PARAMETER Max
An optional API Parameter, enter maximum number of records the API will display.

.PARAMETER Offset
An optional API Parameter, used for pagination of the request.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentsList

.OUTPUTS
System.String. Get-SecuronixIncidentsList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentsList -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -TimeStart 1641040200 -TimeEnd 1641144600 -RangeType Updated

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixIncidentsList.md
#>
function Get-SecuronixIncidentsList {
	[CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory,Position=0)]
		[string] $Url,
		[Parameter(Mandatory,Position=1)]
		[string] $Token,
		[Parameter(Mandatory,Position=2)]
		[string] $TimeStart,
		[Parameter(Mandatory,Position=3)]
		[string] $TimeEnd,
		[Parameter(Mandatory,Position=4)]
		[ValidateSet('opened', 'closed', 'updated')]
		[string] $RangeType,

		[string] $Status,
		[switch] $AllowChildCases,
		[int] $Max,
		[int] $Offset
	)

	Begin {
		. "$PSScriptRoot\lib\Convert-StringTime.ps1"

		if($TimeStart -notmatch '^[\d]+$' ) {
			$PSBoundParameters['TimeStart'] = Convert-StringTime -DateTime $TimeStart
		}
		if($TimeEnd -notmatch '^[\d]+$' ) {
			$PSBoundParameters['TimeEnd'] = Convert-StringTime -DateTime $TimeEnd
		}

		$paramsTable = @{
			'TimeStart' = 'from'
			'TimeEnd' = 'to'
			'RangeType' = 'rangeType'
			'Status' = 'status'
			'AllowChildCases' = 'allowChildCases'
			'Max' = 'max'
			'Offset' = 'offset'
		}

		$params = [ordered]@{'type'='list'}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
		$r = Get-SecuronixIncidentAPIResponse @Params
		return $r.data
	}

	End {}
}

<#
.DESCRIPTION
Get-SecuronixIncidentAttachments makes an API call to the Incident/Get endpoint and retrieves attachments from an incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the attachments.

.PARAMETER TimeStart
A required API Parameter, enter starting point for the search. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS-00'.

.PARAMETER TimeEnd
A required API Parameter, enter ending point for the search. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS-00'.

.PARAMETER AttachmentType
A required API Parameter, select any of: csv, pdf, txt.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentAttachments

.OUTPUTS
System.String. Get-SecuronixIncidentAttachments returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentAttachments -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -IncidentId 1234567890

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixIncidentAttachments.md
#>
function Get-SecuronixIncidentAttachments {

	[CmdletBinding(
		DefaultParameterSetName='default',
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
		[Parameter(ParameterSetName='filtertime',Mandatory)]
		[string] $TimeStart,
		[Parameter(ParameterSetName='filtertime',Mandatory)]
		[string] $TimeEnd,
		[ValidateSet('pdf','csv','txt')]
		[string] $AttachmentType


	)

	Begin {
		. "$PSScriptRoot\lib\Convert-StringTime.ps1"

		if($TimeStart -notmatch '^[\d]+$' ) {
			$PSBoundParameters['TimeStart'] = Convert-StringTime -DateTime $TimeStart
		}
		if($TimeEnd -notmatch '^[\d]+$' ) {
			$PSBoundParameters['TimeEnd'] = Convert-StringTime -DateTime $TimeEnd
		}

		$paramsTable = @{
			'IncidentId' = 'incidentId'
			'AttachmentType' = 'attachmenttype'
			'TimeStart' = 'datefrom'
			'TimeEnd' = 'dateto'
		}

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
			$paramsList += "$($paramsTable[$param])=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/attachments?$($paramsList -join '&')"
	}

	Process {
		if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
			$response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
			return $response.result
		}
	}

	End {}
}

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
		[string] $ParentId
	)

	Begin {
		$paramsTable = @{
			'ParentId' = 'incidentId'
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

<#
.DESCRIPTION
Get-SecuronixIncidentActivityHistory makes an API call to the incident/Get endpoint and retrieves a list of activity and actions taken on an incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the details.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentActivityHistory

.OUTPUTS
System.String. Get-SecuronixIncidentActivityHistory returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentActivityHistory -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '1234567890'

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement
#>
function Get-SecuronixIncidentActivityHistory {
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
		
		$params = [ordered]@{'type'='activityStreamInfo'}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
		$r = Get-SecuronixIncidentAPIResponse @Params
		return $r.activityStreamData
	}

	End {}
}

<#
.DESCRIPTION
Get-SecuronixThreatActions makes an API call to the Incident/Get endpoint and retrieves all actions avaiable for an incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Get-SecuronixThreatActions

.OUTPUTS
System.String. Get-SecuronixThreatActions returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixThreatActions -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixThreatActions.md
#>
function Get-SecuronixThreatActions {
	[CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
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

<#
.DESCRIPTION
Update-SecuronixIncident makes an API call to the Incident/Actions endpoint and updates an incident with the supplied action.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the workflow name.

.PARAMETER ActionName
A required API Parameter. Enter an action that you want to perform for the incident. You can run the Available Threat Actions on an Incident API to view the available actions.

.PARAMETER Attributes
Depending on workflow configured in your organization, add the required attributes. Run Confirm-SecuronixIncidentAction, or Get-SecuronixIncidentActions to view all the attributes (required or not).

.INPUTS
None. You cannot pipe objects to Update-SecuronixIncident

.OUTPUTS
System.String. Update-SecuronixIncident returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Update-SecuronixIncident -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '10029' -ActionName 'comment' -Attributes @{'comment'='comment message';'username'='jhalpert';'firstname'='Jim';'lastname'='Halpert'}

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Update-SecuronixIncident.md
#>
function Update-SecuronixIncident {
	[CmdletBinding(
		DefaultParameterSetName='default',
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory,Position=0)]
		[string] $Url,
		[Parameter(Mandatory,Position=1)]
		[string] $Token,
		[Parameter(ParameterSetName='IncidentId',
			Mandatory,
			Position=2
		)]
		[string] $IncidentId,
		[Parameter(ParameterSetName='bulkcaseids',
			Mandatory
		)]
		[string] $bulkcaseids,
		[Parameter(ParameterSetName='bulkcaseidsList',
			Mandatory
		)]
		[string[]] $bulkcaseidsList,
		[Parameter(Mandatory,Position=2)]
		[string] $ActionName,
		
		[hashtable] $Attributes
	)

	Begin {
		if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

		if($bulkcaseids -ne '') {
			$bulkcaseids = "bulkcaseids=$bulkcaseids"
		}
		if($bulkcaseidsList.Count -gt 0) {
			$list = @()
			foreach($i in $bulkcaseidsList) {
				$list += "bulkcaseids=$i"
			}
			$bulkcaseids = ($list -join '&')
			$PSBoundParameters.Remove('bulkcaseidsList') | Out-Null
		}

		foreach($key in $Attributes.Keys) {
			$PSBoundParameters.Add($key, $Attributes[$key])
		}

		$Exclusions = @(
			'Url', 'Token', 'WhatIf', 'Confirm', 'Verbose',
			'Attributes', 'bulkcaseids'
		)
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }
		###
		$paramsTable = @{
			'IncidentId' = 'incidentId'
			'ActionName' = 'actionName'
		}
		
		$params = @()
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$value = $PSBoundParameters[$param]
			$params += "$key=$value"
		}
		###
		$Uri = "$Url/ws/incident/actions?$($params -join '&')"

		if($bulkcaseids -ne '') {
			$Uri = "$Uri&$bulkcaseids"
		}
	}

	Process {
		if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
			$response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
			return $response
		}
	}


	End {}
}

<#
.DESCRIPTION
Add-SecuronixComment makes an API call to the Incident/Actions endpoint and adds a comment.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter. Enter the incident id of the incident to update.

.PARAMETER Comment
A required parameter. Enter a message to add to an incident.

.PARAMETER Username
An optional parameter. Enter the username of the user adding the comment.

.PARAMETER Firstname
An optional parameter. Enter the first name of the user adding the comment.

.PARAMETER Lastname
An optional parameter. Enter the last name of the user adding the comment.

.INPUTS
None. You cannot pipe objects to Add-SecuronixComment

.OUTPUTS
System.String. Add-SecuronixComment returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Add-SecuronixComment -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '10029' -Comment 'This is a test'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Add-SecuronixComment.md
#>
function Add-SecuronixComment {
	[CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory,Position=0)]
		[string] $Url,
		[Parameter(Mandatory,Position=1)]
		[string] $Token,
		[Parameter(Mandatory,Position=2)]
		[string] $IncidentId,
		[Parameter(Mandatory,Position=3)]
		[string] $Comment,
		
		[string] $Username,
		[string] $Firstname,
		[string] $Lastname
	)

	Begin {		
		$Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
		}

		$Attributes = @{}
		$Attributes.Add('comment', $Comment)

		if($Username -ne '') {
			$Attributes.Add('username', $Username)
		}
		if($Firstname -ne '') {
			$Attributes.Add('firstname', $Firstname)
		}
		if($Lastname -ne '') {
			$Attributes.Add('lastname', $Lastname)
		}
	}

	Process {
		$r = Update-SecuronixIncident -Url $Url -Token $Token -IncidentId $IncidentId -ActionName 'comment' -Attributes $Attributes
		return $r
	}

	End {}
}

<#
.DESCRIPTION
Update-SecuronixCriticality makes an API call to the Incident/Actions endpoint and updates the incidents criticality.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter. Enter the incident id of the incident to update.

.PARAMETER Criticality
A required parameter. Enter the new criticality. Possible values: 'none','low','medium','high','custom'.

.INPUTS
None. You cannot pipe objects to Update-SecuronixCriticality

.OUTPUTS
System.String. Update-SecuronixCriticality returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Update-SecuronixCriticality -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '10029' -Criticality 'high'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Update-SecuronixCriticality.md
#>
function Update-SecuronixCriticality {
	[CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory,Position=0)]
		[string] $Url,
		[Parameter(Mandatory,Position=1)]
		[string] $Token,
		[Parameter(Mandatory,Position=2)]
		[string] $IncidentId,
		[Parameter(Mandatory,Position=3)]
		[ValidateSet('none','low','medium','high','custom')]
		[string] $Criticality
	)

	Begin {		
		$Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
		}

		$Attributes = @{}
		$Attributes.Add('criticality', $Criticality)
		$Attributes.Add('changecriticality', 'true')


	}

	Process {
		$r = Update-SecuronixIncident -Url $Url -Token $Token -IncidentId $IncidentId -ActionName 'comment' -Attributes $Attributes
		return $r
	}

	End {}
}

<#
.DESCRIPTION
New-SecuronixIncident makes an API call to the Incident/Actions endpoint and creates a new incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter. Enter the incident id of the incident to update.

.PARAMETER ViolationName
A required API Parameter. Enter the violation policy name.

.PARAMETER DatasourceName
A required API Parameter. Enter the resource group name.

.PARAMETER EntityType
A required API Parameter. Enter any of the following types: Users, Activityaccount, RGActivityaccount, Resources, Activityip.

.PARAMETER EntityName
A required API Parameter. Enter the accountname associated with the violation.

.PARAMETER Workflow
A required API Parameter. Enter the workflow name.

.PARAMETER Comment
An optional API Parameter. Enter an additional comment.

.PARAMETER EmployeeId
An optional API Parameter. Enter the employee id.

.PARAMETER Criticality
A required parameter. Enter the new criticality. Possible values: 'none','low','medium','high','custom'.

.INPUTS
None. You cannot pipe objects to New-SecuronixIncident

.OUTPUTS
System.String. New-SecuronixIncident returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> New-SecuronixIncident -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -ViolationName 'Repeated Visits to Potentially Malicious address' -DatasourceName 'Websense Proxy' -EntityType 'Activityip' -EntityName '134.119.189.29' -Workflow 'SOCTeamReview'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/New-SecuronixIncident.md
#>
function New-SecuronixIncident {
	[CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory,Position=0)]
		[string] $Url,
		[Parameter(Mandatory,Position=1)]
		[string] $Token,
		[Parameter(Mandatory,Position=2)]
		[string] $ViolationName,
		[Parameter(Mandatory,Position=3)]
		[string] $DatasourceName,
		[Parameter(Mandatory,Position=4)]
		[ValidateSet('Users','Activityaccount','RGActivityaccount','Resources','Activityip')]
		[string] $EntityType,
		[Parameter(Mandatory,Position=5)]
		[string] $EntityName,
		[Parameter(Mandatory,Position=6)]
		[string] $Workflow,

		[string] $Comment,
		[string] $EmployeeId,
		[ValidateSet('none','low','medium','high','custom')]
		[string] $Criticality

	)

	Begin {		
		$Exclusions = @('Url','Token','WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
		}

		$AttrsTable = @{
			'Comment' = 'comment'
			'Criticality' = 'criticality'
			'EmployeeId' = 'employeeId'
			'DatasourceName' = 'datasourceName'
			'EntityType' = 'entityType'
			'EntityName' = 'entityName'
			'ResourceName' = 'resourceName'
			'ViolationName' = 'violationName'

		}
		$Attributes = [ordered]@{}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($AttrsTable.Keys -Contains $param) { $AttrsTable[$param] } else { $param }
			$Attributes[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
		$r = Update-SecuronixIncident -Url $Url -Token $Token -ActionName 'Mark as concern and create incident' -Attributes $Attributes
		return $r
	}

	End {}
}

<#
.DESCRIPTION
Add-SecuronixViolationScore makes an API call to the Incident/Actions endpoint and updates an incident with the supplied action.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER ScoreIcrement
A required API parameter. Only accepts positive integers, enter the value to increase the violation score by.

.PARAMETER TenantName
A required API parameter. The name of the tenant the entity belongs to.

.PARAMETER ViolationName
A required API parameter. Name of the violation/policy to increase the violation score.

.PARAMETER PolicyCategory
A required API parameter. Policy category name of the policy being acted on.

.PARAMETER EntityType
A required API parameter. Type of entity, enter any of: Users, Activityaccount, Resources, IpAddress.

.PARAMETER EntityName
A required API parameter. Entityid/name of the entity being added. accountname for Activityaccount, userid for Users, ipadress for ActivityIp, resourceName for resources.

.PARAMETER ResourceGroupName
Required if EntityType is not Users. Enter the name of the resource group the entity belongs to.

.PARAMETER ResourceName
Required if EntityType is not Users. Enter the name of the resource the entity belongs to.

.INPUTS
None. You cannot pipe objects to Add-SecuronixViolationScore

.OUTPUTS
System.String. Add-SecuronixViolationScore returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Add-SecuronixViolationScore -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -ScoreIncrement 1 -TenantName 'Automationtenant' -ViolationName 'policy' -PolicyCategory 'category' -EntityType 'Users' -EntityName 'xyz' -ResourceGroupname 'rgGroup' -ResourceName 'resource'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Add-SecuronixViolationScore.md
#>
function Add-SecuronixViolationScore {
	[CmdletBinding(
		DefaultParameterSetName='default',
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory,Position=0)]
		[string] $Url,
		[Parameter(Mandatory,Position=1)]
		[string] $Token,
		[Parameter(Mandatory,Position=2)]
		[int] $ScoreIncrement,
		[Parameter(Mandatory,Position=3)]
		[string] $TenantName,
		[Parameter(Mandatory,Position=4)]
		[string] $ViolationName,
		[Parameter(Mandatory,Position=5)]
		[string] $PolicyCategory,
		[Parameter(Mandatory,Position=6)]
		[ValidateSet('Users','Activityaccount','RGActivityaccount','Resources','Activityip')]
		[string] $EntityType,
		[Parameter(Mandatory,Position=7)]
		[string] $EntityName,
		[Parameter(Mandatory,Position=8)]
		[string] $ResourceGroupName,
		[Parameter(Mandatory,Position=9)]
		[string] $ResourceName
	)

	Begin {
		if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

		$Exclusions = @(
			'Url', 'Token', 'WhatIf', 'Confirm', 'Verbose'
		)
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }
		
		$paramsTable = @{
			'ScoreIcrement' = 'scoreIncrement'
			'TenantName' = 'tenantname'
			'ViolationName' = 'violationName'
			'PolicyCategory' = 'policyCategory'
			'EntityType' = 'entityType'
			'EntityName' = 'entityName'
			'ResourceGroupName' = 'resourcegroupName'
			'ResourceName' = 'resourceName'
		}
		
		$params = @()
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$value = $PSBoundParameters[$param]
			$params += "$key=$value"
		}
		
		$Uri = "$Url/ws/incident/updateViolationScore?$($params -join '&')"
	}

	Process {
		if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
			$response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
			return $response
		}
	}


	End {}
}

Export-ModuleMember -Function Get-SecuronixIncidentAPIResponse
Export-ModuleMember -Function Get-SecuronixIncident
Export-ModuleMember -Function Get-SecuronixIncidentStatus
Export-ModuleMember -Function Get-SecuronixIncidentWorkflowName
Export-ModuleMember -Function Get-SecuronixIncidentActions
Export-ModuleMember -Function Confirm-SecuronixIncidentAction
Export-ModuleMember -Function Get-SecuronixWorkflowsList
Export-ModuleMember -Function Get-SecuronixWorkflowDetails
Export-ModuleMember -Function Get-SecuronixWorkflowDefaultAssignee
Export-ModuleMember -Function Get-SecuronixIncidentsList
Export-ModuleMember -Function Get-SecuronixIncidentAttachments
Export-ModuleMember -Function Get-SecuronixChildIncidents
Export-ModuleMember -Function Get-SecuronixIncidentActivityHistory
Export-ModuleMember -Function Get-SecuronixThreatActions
Export-ModuleMember -Function Add-SecuronixComment
Export-ModuleMember -Function Update-SecuronixIncident
Export-ModuleMember -Function Update-SecuronixCriticality
Export-ModuleMember -Function New-SecuronixIncident
Export-ModuleMember -Function Add-SecuronixViolationScore