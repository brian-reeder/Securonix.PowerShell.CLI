<#
.DESCRIPTION
Get-SecuronixPolicyList prepares API parameters and queries the Securonix for a list of all Policies.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Get-SecuronixPolicyList

.OUTPUTS
System.String. Get-SecuronixPolicyList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixPolicyList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/List/Get-SecuronixPolicyList.md
#>
function Get-SecuronixPolicyList {
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
        $Header = @{
            'token' = $Token
        }

        $Uri = "$Url/ws/policy/getAllPolicies"
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
Get-SecuronixResourcegroupList prepares API parameters and queries the Securonix for a list of all Resource Groups configured by Snypr for monitoring.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Get-SecuronixResourcegroupList

.OUTPUTS
System.String. Get-SecuronixResourcegroupList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixResourcegroupList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/List/Get-SecuronixResourcegroupList.md
#>
function Get-SecuronixResourcegroupList {
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
        $Header = @{
            'token' = $Token
        }

        $Uri = "$Url/ws/list/resourceGroups"
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
Get-SecuronixPeerGroupsList prepares API parameters and queries the Securonix for a list of all Peer Groups configured by Snypr for monitoring.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Get-SecuronixPeerGroupsList

.OUTPUTS
System.String. Get-SecuronixPeerGroupsList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixPeerGroupsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/List/Get-SecuronixPeerGroupsList.md
#>
function Get-SecuronixPeerGroupsList {
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
        $Header = @{
            'token' = $Token
        }

        $Uri = "$Url/ws/list/peerGroups"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}

Export-ModuleMember -Function Get-SecuronixPolicyList 
Export-ModuleMember -Function Get-SecuronixResourcegroupList
Export-ModuleMember -Function Get-SecuronixPeerGroupsList