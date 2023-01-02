<#
.DESCRIPTION
Get-SecuronixSearchAPIResponse is a flexible controller used to process Securonix Search calls. Use the higher level interfaces to enforce parameter guidelines.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentAPIResponse

.OUTPUTS
System.String. Get-SecuronixIncidentAPIResponse returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE

.LINK
#>
function Get-SecuronixSearchAPIResponse {
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
        [string] $query,

        [string] $eventtime_from,
        [string] $eventtime_to,
        [string] $generationtime_from,
        [string] $generationtime_to,
        [string] $tz,
        [bool] $prettyJson,
        [int] $max,
        [string] $queryId
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
		
		$Uri = "$Url/ws/spotter/index/search?$($paramsList -join '&')"
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
Get-SecuronixActivityEvents prepares API parameters and calls the Securonix Search API endpoint to receive matching Event logs.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentAPIResponse

.OUTPUTS
System.String. Get-SecuronixIncidentAPIResponse returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE

.LINK
#>
function Get-SecuronixActivityEvents {
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
        [string] $TimeStart,
        [Parameter(Mandatory)]
        [string] $TimeEnd,

        [AllowEmptyString()]
        [string] $Query = '',

        [string] $TimeZone,
        [bool] $PrettyJson,
        [int] $Max,
        [string] $QueryId
	)

	Begin {
		$paramsTable = @{
            'Query' = 'query'
			'TimeStart' = 'eventtime_from'
			'TimeEnd' = 'eventtime_to'
			'TimeZone' = 'tz'
			'PrettyJson' = 'prettyJson'
			'Max' = 'max'
			'QueryId' = 'queryId'
		}

        if($PSBoundParameters.ContainsKey('WhatIf')) {
            $PSBoundParameters.Remove('WhatIf') |  Out-Null
        }

        if($Query -ne '') {
            $PSBoundParameters['Query'] = "index=activity AND $($Query)"
        }
        else {
            $PSBoundParameters['Query'] = 'index=activity'
        }

		$params = [ordered]@{}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
        $r = Get-SecuronixSearchAPIResponse @Params
        return $r
	}

	End {}
}
