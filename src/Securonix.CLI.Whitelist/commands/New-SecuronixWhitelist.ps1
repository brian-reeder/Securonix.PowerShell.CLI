<#
.DESCRIPTION
New-SecuronixWhitelist prepares API parameters and requests Securonix to create a new whitelist.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WhitelistName
A required API Parameter, the name of the whitelist you want to create.

.PARAMETER TenantName
A required API Parameter, the name of the tenant this whitelist should belong to.

.PARAMETER EntityType
A required API Parameter, enter the type of entity this whitelist is intended to hold. May be the following types: 'Users', 'Activityaccount', 'Resources', 'IpAddress'.

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
        [ValidateSet('Users', 'Activityaccount', 'Resources', 'IpAddress')]
		[string] $EntityType
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