<#
.DESCRIPTION
Get-SecuronixWatchlistList prepares API parameters and queries the Securonix API for a list of all watchlists.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Get-SecuronixWatchlistList

.OUTPUTS
System.String. Get-SecuronixWatchlistList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixWatchlistList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -DocumentId 'test_watchlist'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Watchlist/Get-SecuronixWatchlistList.md
#>
function Get-SecuronixWatchlistList {
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
        if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}
		
		$Uri = "$Url/ws/incident/listWatchlist"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}