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
		[int] $offset
	)

	Begin {
		if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

		$paramsTable = @{
			'IncidentId' = 'incidentId'
		}

		$o = $PSBoundParameters.Remove('Url');
		$o = $PSBoundParameters.Remove('Token');
		
		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
			$paramsList += "$($paramsTable[$param])=$($PSBoundParameters[$param])"
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
		[string] $IncidentId,
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
		return Get-SecuronixIncidentAPIResponse @Params
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
		[string] $IncidentId,
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
		return Get-SecuronixIncidentAPIResponse @Params
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
		if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

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

		$o = $PSBoundParameters.Remove('Url');
		$o = $PSBoundParameters.Remove('Token');
		
		$paramsList = @('type=list')
		foreach($param in $PSBoundParameters.Keys) {
			$paramsList += "$($paramsTable[$param])=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/get?$($paramsList -join '&')"
	}

	Process {
		$response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
		return $response.result
	}

	End {}
}

Export-ModuleMember -Function Get-SecuronixIncident
Export-ModuleMember -Function Get-SecuronixIncidentsList 
