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
	[System.Diagnostics.CodeAnalysis.SuppressMessage('PSShouldProcess', '',
        Scope='Function',
        Justification='ShouldProcess is handled by the function Get-SecuronixIncidentAPIResponse'
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
		$PSBoundParameters['TimeStart'] = Convert-StringTime -InputDateTime $TimeStart -OutEpoch
        $PSBoundParameters['TimeEnd']   = Convert-StringTime -InputDateTime $TimeEnd -OutEpoch

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
		return $r.data.incidentItems
	}

	End {}
}