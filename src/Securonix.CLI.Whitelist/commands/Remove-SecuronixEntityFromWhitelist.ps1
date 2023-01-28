<#
.DESCRIPTION
Remove-SecuronixAttributeFromWhitelist prepares API parameters and requests Securonix to remove an entity from a whitelist.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WhitelistName
A required API Parameter, the name of the whitelist you want to remove an entity from.

.PARAMETER TenantName
A required API Parameter, the name of the tenant the whitelist belongs to.

.PARAMETER EntityId
A required API Parameter, the id to remove from a whitelist. Employeeid for type User, accountname for type Activityaccount, resourcename for type Resources, and ipaddress for type IpAddress

.PARAMETER EntityIdList
A required API Parameter, a list of Entity Ids to remove from a whitelist. Max number of 5 at a time.

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