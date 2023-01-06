<#
.DESCRIPTION
New-SecuronixWhitelist prepares API parameters and requests Securonix to create a new watchlist.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WhitelistName
A required API Parameter, the name of the whitelist you want to create.

.PARAMETER TenantName
A required API Parameter, the name of the tenant this whitelist should belong to.

.PARAMETER EntityType
A required API Parameter, enter the type of entity thie whitelist is intended to hold. May be the following types: 'Users', 'Activityaccount', 'Resources', 'IpAddress'.

.INPUTS
None. You cannot pipe objects to New-SecuronixWhitelist

.OUTPUTS
System.String. New-SecuronixWhitelist returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> New-SecuronixWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'test_whitelist' -TenantName 'PA-Scranton' -EntityType 'Users'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Whitelist/New-SecuronixWhitelist.md
#>
function New-SecuronixWhitelist {
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
		[string] $WhitelistName,
        [Parameter(Mandatory)]
		[string] $TenantName,
        [Parameter(Mandatory)]
		[string] $EntityType
	)

	Begin {
        if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

        $EntityTypeSet = @('Users', 'Activityaccount', 'Resources', 'IpAddress')	
		if($EntityTypeSet -NotContains $EntityType.ToLower()) {
			throw "Invalid EntityType provided. You entered `"$($EntityType)`". Valid values: $($EntityTypeSet)."
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
            'TenantName' = 'tenantname'
            'EntityType' = 'entitytype'
		}

		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/createGlobalWhitelist?$($paramsList -join '&')"
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
Remove-SecuronixEntityFromWhitelist prepares API parameters and requests Securonix to create a new watchlist.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WhitelistName
A required API Parameter, the name of the whitelist you want to create.

.PARAMETER TenantName
A required API Parameter, the name of the tenant the whitelist belongs to.

.PARAMETER EntityId
A required API Parameter, the id to remove from a whitelist. Employeeid for type User, accountname for type Activityaccount, resourcename for type Resources, and ipaddress for type IpAddress

.PARAMETER EntityIdList
A required API Parameter, a list of Entity Ids to remove from a watch list. Max number of 5 at a time.

.INPUTS
None. You cannot pipe objects to Remove-SecuronixEntityFromWhitelist

.OUTPUTS
System.String. Remove-SecuronixEntityFromWhitelist returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Remove-SecuronixEntityFromWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'remote_users' -TenantName 'PA-Scranton' -EntityId 'jhalpert'

.EXAMPLE
PS> Remove-SecuronixEntityFromWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'datacenter_ips' -TenantName 'NY-New_York_City' -EntityIdList @('192.168.0.1','172.16.0.1','10.0.0.1','127.0.0.1')

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Whitelist/Remove-SecuronixEntityFromWhitelist.md
#>
function Remove-SecuronixEntityFromWhitelist {
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
            Mandatory,
            Position=2
        )]
		[string] $WhitelistName,
        [Parameter(
            Mandatory,
            Position=3
        )]
		[string] $TenantName,
        [Parameter(
            ParameterSetName='single',
            Mandatory,
            Position=4
        )]
		[string] $EntityId,
        [Parameter(
            ParameterSetName='list',
            Mandatory,
            Position=4
        )]
		[string[]] $EntityIdList
	)

	Begin {
        if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

        if($EntityIdList.Count -gt 5) {
            throw "Too many Entity Ids provided. Max 5 supported by API, you entered `"$($EntityIdList.count)`"."
        }
        elseif ($EntityIdList.Count -gt 0) {
            $EntityId = $EntityIdList -join ','
            $PSBoundParameters.Add('EntityId', $EntityId)
            $PSBoundParameters.Remove('EntityIdList') | Out-Null
        }

		$Header = [ordered]@{
			'token' = $Token
		}

        $Exclusions = @('Url', 'Token', 'WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        $paramsTable = @{
            'WhitelistName' = 'whitelistname'
            'TenantName' = 'tenantname'
            'EntityId' = 'entityid'
		}

		$paramsList = @('whitelisttype=global')
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/removeFromWhitelist?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}