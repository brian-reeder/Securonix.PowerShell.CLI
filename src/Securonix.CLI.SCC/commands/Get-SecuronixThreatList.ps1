<#
.DESCRIPTION
Get-SecuronixThreatList prepares API parameters and queries the Securonix for a list of all threats violated in a time range.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER TimeStart
A required API Parameter, enter starting point for the search. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS-00'.

.PARAMETER TimeEnd
A required API Parameter, enter ending point for the search. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS-00'.

.PARAMETER Offset
An optional API Parameter, used for pagination of the request.

.PARAMETER Max
An optional API Parameter, enter maximum number of records the API will display.

.PARAMETER TenantName
Enter the name of the tenant the threat model belongs to. This parameter is optional for non-MSSP.

.INPUTS
None. You cannot pipe objects to Get-SecuronixThreatList

.OUTPUTS
System.String. Get-SecuronixThreatList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixThreatList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -TimeStart 299721600 -TimeEnd 299807999

.EXAMPLE
PS> Get-SecuronixThreatList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -TimeStart 299721600 -TimeEnd 299807999 -TenantName 'PA-Scranton'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Security%20Command%20Center/Get-SecuronixThreatList.md
#>
function Get-SecuronixThreatList {
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
		[int] $Offset = 0,
		[int] $Max    = 10,
		[string] $TenantName
	)

	Begin {
        $PSBoundParameters['Offset'] = $Offset
        $PSBoundParameters['Max']    = $Max

		$PSBoundParameters['TimeStart'] = Convert-StringTime -InputDateTime $TimeStart -OutEpoch
        $PSBoundParameters['TimeEnd']   = Convert-StringTime -InputDateTime $TimeEnd -OutEpoch

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

        $paramsTable = @{
			'TimeStart' = 'datefrom'
			'TimeEnd' = 'dateto'
            'Offset' = 'offset'
			'Max' = 'max'
            'TenantName' = 'tenantname'
		}

		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}

		$Uri = "$Url/ws/sccWidget/getThreats?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response.Response.threats
        }
	}

	End {}
}