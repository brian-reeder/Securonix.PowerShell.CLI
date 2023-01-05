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
PS> New-SecuronixWatchlist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -DocumentId 'test_watchlist'

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

<#
.DESCRIPTION
Get-SecuronixEntityWatchlists prepares API parameters and requests Securonix to list all watchlists an entity is a member of.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER EntityId
A required API Parameter, the unique id to find watchlist memberships for. If the entitytype is users, the entityid will be the employeeid.

.PARAMETER WatchlistName
An optional API Parameter, the name of the watchlist to check for an entities membership.

.INPUTS
None. You cannot pipe objects to Get-SecuronixEntityWatchlists

.OUTPUTS
System.String. Get-SecuronixEntityWatchlists returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixEntityWatchlists -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -EntityId 'kslagg'

.EXAMPLE
PS> Get-SecuronixEntityWatchlists -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -EntityId 'kslagg' -WatchlistName 'test_watchlist'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Watchlist/Get-SecuronixEntityWatchlists.md
#>
function Get-SecuronixEntityWatchlists {
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

<#
.DESCRIPTION
Add-SecuronixEntityToWatchlist prepares API parameters and requests Securonix to list all watchlists an entity is a member of.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER EntityId
A required API Parameter, the unique id to find watchlist memberships for. If the entitytype is users, the entityid will be the employeeid.

.PARAMETER EntityIdList
A required API Parameter, a list of Entity Ids to add to a watch list. Max number of 5 at a time. 

.PARAMETER WatchlistName
A required API Parameter, the name of the watchlist to add entity membership.

.PARAMETER EntityType
A required API Parameter, enter the type of entity you are adding. May be the following types: 'Users', 'Activityaccount', 'Resource', 'Activityip'.
		
.PARAMETER ExpiryDays
A required API Parameter, enter the number of days for the account to be on the watch list.

.PARAMETER ResourceGroupId
A required API Parameter, enter the resource group id that the entity will be monitored from. If the resource type is Users, this will be set to -1.

.INPUTS
None. You cannot pipe objects to Add-SecuronixEntityToWatchlist

.OUTPUTS
System.String. Add-SecuronixEntityToWatchlist returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Add-SecuronixEntityToWatchlist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -EntityId 'jhalpert' -WatchlistName 'test_watchlist' -EntityType 'Users' -EntityDays 90 -ResourceGroupId '-1'

.EXAMPLE
PS> Add-SecuronixEntityToWatchlist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -EntityIdList @('jhalpert','dshrute','pbeesley','mscott','mpalmer') -WatchlistName 'test_watchlist' -EntityType 'Users' -EntityDays 90 -ResourceGroupId '-1'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Watchlist/Get-SecuronixEntityWatchlists.md
#>
function Add-SecuronixEntityToWatchlist {
    [CmdletBinding(
        DefaultParameterSetName='single',
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(
            Mandatory,
            Position=0
        )]
		[string] $Url,
		[Parameter(
            Mandatory,
            Position=1
        )]
		[string] $Token,
        [Parameter(
            ParameterSetName='single',
            Mandatory,
            Position=2
        )]
		[string] $EntityId,
        [Parameter(
            ParameterSetName='list',
            Mandatory,
            Position=2
        )]
		[string[]] $EntityIdList,
        [Parameter(
            Mandatory,
            Position=3
        )]
        [string] $WatchlistName,
        [Parameter(
            Mandatory,
            Position=4
        )]
		[string] $EntityType,
        [Parameter(
            Mandatory,
            Position=5
        )]
		[int] $ExpiryDays,
        [Parameter(
            Mandatory,
            Position=6
        )]
		[string] $ResourceGroupId
	)

	Begin {
        $EntityTypeSet = @('Users', 'Activityaccount', 'Resource', 'Activityip')	
		if($EntityTypeSet -NotContains $EntityType.ToLower()) {
			throw "Invalid EntityType provided. You entered `"$($EntityType)`". Valid values: $($EntityTypeSet)."
		}
        if($EntityType -eq 'Users') {
            $PSBoundParameters['ResourceGroupId'] = '-1'
        }

        if($EntityIdList.Count -gt 5) {
            throw "Too many Entity Ids provided. Max 5 supported by API, you entered `"$($EntityIdList.count)`"."
        }
        elseif ($EntityIdList.Count -gt 0) {
            $EntityId = $EntityIdList -join ','
            $PSBoundParameters.Add('EntityId', $EntityId)
            $PSBoundParameters.Remove('EntityIdList')
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

        $paramsTable = @{
            'EntityId' = 'entityId'
            'WatchlistName' = 'watchlistname'
            'EntityType' = 'entitytype'
            'ExpiryDays' = 'expirydays'
            'ResourceGroupId' = 'resourcegroupid'
		}

		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/addToWatchlist?$($paramsList -join '&')"
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
Get-SecuronixWatchlistMembers prepares API parameters and requests Securonix to list all watchlists an entity is a member of.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WatchlistName
A required API Parameter, the name of the watchlist to list membership.

.INPUTS
None. You cannot pipe objects to Get-SecuronixWatchlistMembers

.OUTPUTS
System.String. Get-SecuronixWatchlistMembers returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixWatchlistMembers -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WatchlistName 'test_watchlist'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Watchlist/Get-SecuronixWatchlistMembers.md
#>
function Get-SecuronixWatchlistMembers {
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
		
		$Uri = "$Url/ws/incident/listWatchlistEntities?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}