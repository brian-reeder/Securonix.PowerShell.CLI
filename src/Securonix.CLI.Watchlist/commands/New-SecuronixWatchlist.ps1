<#
.DESCRIPTION
New-SecuronixWatchlist prepares API parameters and requests Securonix to create a new watchlist.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WatchlistName
A required API Parameter, the name of the watchlist you want to create.

.INPUTS
None. You cannot pipe objects to New-SecuronixWatchlist

.OUTPUTS
System.String. New-SecuronixWatchlist returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> New-SecuronixWatchlist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WatchlistName 'test_watchlist'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Watchlist/New-SecuronixWatchlist.md
#>
function New-SecuronixWatchlist {
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
		[string] $WatchlistName
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

        $paramsTable = @{
            'WatchlistName' = 'watchlistname'
		}

		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/createWatchlist?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}