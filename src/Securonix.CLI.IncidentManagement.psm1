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
None. You cannot pipe objects to Get-SecuronixChildIncidents

.OUTPUTS
System.String. Get-SecuronixChildIncidents returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixChildIncidents -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -IncidentId 1234567890

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
		DefaultParameterSetName='IncidentId',
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
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixThreatActions.md
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
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixThreatActions.md
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