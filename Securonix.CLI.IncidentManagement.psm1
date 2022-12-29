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

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentsList

.OUTPUTS
System.String. Get-SecuronixIncidentsList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentsList -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -TimeStart 1641040200 -TimeEnd 1641144600 -RangeType Updated

.LINK
https://documentation.securonix.com/onlinedoc/Content/Cloud/Content/SNYPR%206.3/Web%20Services/6.3_REST%20API%20Categories.htm#Auth
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

		[string] $Status
	)

	Begin {
		if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

		$params = [ordered]@{
			'type' = 'list'
			'from' = $TimeStart
			'to'  = $TimeEnd
			'rangeType' = $RangeType
		}
		
		if($Status -ne $null) {
			$params['status'] = $Status
		}
		
		$paramsList = @()
		foreach($param in $params.Keys) {
			$paramsList += "$($param)=$($params[$param])"
		}
		
		$Uri = "$Url/ws/incident/get?$($paramsList -join '&')"
	}

	Process {
		$response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
		return $response.result
	}

	End {}
}

Export-ModuleMember -Function Get-SecuronixIncidentsList 
