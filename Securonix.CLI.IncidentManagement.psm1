<#
.DESCRIPTION
Get-SecuronixIncidentAPIResponse is a flexible controller used to process Securonix Incident Management calls. Use the higher level interfaces to enforce parameter guidelines.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER type
A required API Parameter, enter the API type to view the details.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentAPIResponse

.OUTPUTS
System.String. Get-SecuronixIncidentAPIResponse returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentAPIResponse -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -type "metaInfo" -incidentId "1234567890"

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement
#>
function Get-SecuronixIncidentAPIResponse {
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token,
		[Parameter(Mandatory)]
		[string] $type,
		
		[string] $incidentId,
		[string] $from,
		[string] $to,
		[string] $rangeType,
		[string] $status,
		[switch] $allowChildCases,
		[int] $max,
		[int] $offset,
		[string] $actionName,
		[string] $workflowname,
		[string] $workflow
	)

	Begin {
		if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

		$PSBoundParameters.Remove('Url') | Out-Null
		$PSBoundParameters.Remove('Token') | Out-Null
		
		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
			$paramsList += "$($param)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/get?$($paramsList -join '&')"
	}

	Process {
		$response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
		return $response.result
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
PS> Get-SecuronixIncident -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -IncidentId 1234567890

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement
#>
function Get-SecuronixIncident {
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
		$r = Get-SecuronixIncidentAPIResponse @Params
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
A required API Parameter, enter the incident id to view the details.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentStatus

.OUTPUTS
System.String. Get-SecuronixIncidentStatus returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentStatus -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -IncidentId 1234567890

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement
#>
function Get-SecuronixIncidentStatus {
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
		$r = Get-SecuronixIncidentAPIResponse @Params
		return $r.status
	}

	End {}
}

<#
.DESCRIPTION
Get-SecuronixIncidenSecuronixIncidentWorkflowNametStatus makes an API call to the Incident/Get endpoint and retrieves the status of an incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the details.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentWorkflowName

.OUTPUTS
System.String. Get-SecuronixIncidentWorkflowName returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentWorkflowName -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -IncidentId 1234567890

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement
#>
function Get-SecuronixIncidentWorkflowName {
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
Get-SecuronixIncidentActions makes an API call to the Incident/Get endpoint and retrieves the actions available for an Incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the details.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentActions

.OUTPUTS
System.String. Get-SecuronixIncidentActions returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentActions -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -IncidentId 1234567890

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement
#>
function Get-SecuronixIncidentActions {
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

.INPUTS
None. You cannot pipe objects to Confirm-SecuronixIncidentAction

.OUTPUTS
System.String. Confirm-SecuronixIncidentAction returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Confirm-SecuronixIncidentAction -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -IncidentId "1234567890" -ActionName "CLAIM"

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement
#>
function Confirm-SecuronixIncidentAction {
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
Get-SecuronixWorkflowsList makes an API call to the Incident/Get endpoint and retrieves the list of available Workflows for Incidents.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the details.

.INPUTS
None. You cannot pipe objects to Get-SecuronixWorkflowsList

.OUTPUTS
System.String. Get-SecuronixWorkflowsList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixWorkflowsList -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -IncidentId 1234567890

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement
#>
function Get-SecuronixWorkflowsList {
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token
	)

	Begin {}

	Process {
		$r = Get-SecuronixIncidentAPIResponse -type 'workflows'
		return $r
	}

	End {}
}

<#
.DESCRIPTION
Get-SecuronixWorkflowDetails makes an API call to the Incident/Get endpoint and retrieves the status/action details for an Incident Workflow.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the details.

.INPUTS
None. You cannot pipe objects to Get-SecuronixWorkflowDetails

.OUTPUTS
System.String. Get-SecuronixWorkflowDetails returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixWorkflowDetails -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -WorkflowName SOCTeamReview

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement
#>
function Get-SecuronixWorkflowDetails {
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
		$r = Get-SecuronixIncidentAPIResponse @Params
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

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the details.

.INPUTS
None. You cannot pipe objects to Get-SecuronixWorkflowDefaultAssignee

.OUTPUTS
System.String. Get-SecuronixWorkflowDefaultAssignee returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixWorkflowDefaultAssignee -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -WorkflowName SOCTeamReview

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement
#>
function Get-SecuronixWorkflowDefaultAssignee {
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
A required API Parameter, enter starting point for the search. Time (epoch) in ms.

.PARAMETER TimeEnd
A required API Parameter, enter ending point for the search. Time (epoch) in ms.

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
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement
#>
function Get-SecuronixIncidentsList {
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token,
		[Parameter(Mandatory)]
		[string] $TimeStart,
		[Parameter(Mandatory)]
		[string] $TimeEnd,
		[Parameter(Mandatory)]
		[string] $RangeType,

		[string] $Status,
		[switch] $AllowChildCases,
		[int] $Max,
		[int] $Offset
	)

	Begin {
		$RangeTypeSet = @('opened', 'closed', 'updated')	
		if($RangeTypeSet -NotContains $RangeType.ToLower()) {
			throw "Invalid RangeType provided. You entered `"$($RangeType)`". Valid values: $($RangeTypeSet)."
		}
		$RangeType = $RangeType.ToLower()

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
A required API Parameter, enter the incident id to view the details.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentAttachments

.OUTPUTS
System.String. Get-SecuronixIncidentAttachments returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentAttachments -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -IncidentId 1234567890

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#IncidentManagement
#>
function Get-SecuronixIncidentAttachments {
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token,
		[Parameter(Mandatory)]
		[string] $IncidentId,

		[string] $AttachmentType,
		[string] $TimeStart,
		[string] $TimeEnd


	)

	Begin {
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

		$PSBoundParameters.Remove('Url') | Out-Null
		$PSBoundParameters.Remove('Token') | Out-Null
		
		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
			$paramsList += "$($paramsTable[$param])=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/attachments?$($paramsList -join '&')"
	}

	Process {
		$response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
		return $response.result
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
function Get-SecuronixChildIncidents {
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
Get-SecuronixChildIncidents makes an API call to the Incident/Get endpoint and retrieves all children incident ids of an incident.

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