<#
.DESCRIPTION
Get-SecuronixEntityWatchlistList prepares API parameters and requests Securonix to list all watchlists an entity is a member of.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER EntityId
A required API Parameter, the unique id to find watchlist memberships for. If the entitytype is users, the entityid will be the employeeid.

.PARAMETER WatchlistName
An optional API Parameter, the name of the watchlist to check for an entities membership.

.INPUTS
None. You cannot pipe objects to Get-SecuronixEntityWatchlistList

.OUTPUTS
System.String. Get-SecuronixEntityWatchlistList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixEntityWatchlistList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -EntityId 'kslagg'

.EXAMPLE
PS> Get-SecuronixEntityWatchlistList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -EntityId 'kslagg' -WatchlistName 'test_watchlist'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Watchlist/Get-SecuronixEntityWatchlistList.md
#>
function Get-SecuronixEntityWatchlistList {
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
		[string] $EntityId,

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
            'EntityId' = 'entityid'
            'WatchlistName' = 'watchlistname'
		}

		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}

		$Uri = "$Url/ws/incident/checkIfWatchlisted?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}