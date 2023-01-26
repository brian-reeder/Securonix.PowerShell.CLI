<#
.DESCRIPTION
Get-SecuronixWhitelistMembers prepares API parameters and requests Securonix to get the list of members for a Whitelist.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WhitelistName
A required API Parameter, the name of the whitelist you want to find.

.PARAMETER TenantName
A required API Parameter, the name of the tenant the whitelist belongs to.

.INPUTS
None. You cannot pipe objects to Get-SecuronixWhitelistMembers.

.OUTPUTS
System.String. Get-SecuronixWhitelistMembers returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixWhitelistMembers -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'remote_users' -TenantName 'PA-Scranton'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Whitelist/Get-SecuronixWhitelist.md
#>
function Get-SecuronixWhitelistMembers {
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
		[string] $TenantName
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
            'WhitelistName' = 'whitelistname'
            'TenantName' = 'tenantname'
		}
		
        $paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/listWhitelistEntities?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}