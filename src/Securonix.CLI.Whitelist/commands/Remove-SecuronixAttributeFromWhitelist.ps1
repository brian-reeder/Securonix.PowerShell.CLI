<#
.DESCRIPTION
Remove-SecuronixAttributeFromWhitelist prepares API parameters and requests Securonix to remove an attribute from a whitelist.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WhitelistName
A required API Parameter, the name of the whitelist to remove an attribute from.

.PARAMETER TenantName
A required API Parameter, the name of the tenant the whitelist belongs to.

.PARAMETER AttributeName
A required API Parameter, the name of an attribute being removed. Possible values include: accountname, transactionstring, sourcetype.

.PARAMETER AttributeValue
A required API Parameter, the value of the attribute to remove from a whitelist.

.PARAMETER AttributeValueList
A required API Parameter, a list of Attribute Values to remove from a white list. Max number of 5 at a time.

.INPUTS
None. You cannot pipe objects to Remove-SecuronixAttributeFromWhitelist

.OUTPUTS
System.String. Remove-SecuronixAttributeFromWhitelist returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Remove-SecuronixAttributeFromWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'remote_users' -TenantName 'PA-Scranton' -AttributeName 'accountname' -AttributeValue 'jhalpert'

.EXAMPLE
PS> Remove-SecuronixAttributeFromWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'remote_users' -TenantName 'PA-Scranton' -AttributeName 'accountname' -AttributeValueList @('jhalpert','dshrute','mscott')

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Whitelist/Remove-SecuronixEntityFromWhitelist.md
#>
function Remove-SecuronixAttributeFromWhitelist {
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
            Mandatory,
            Position=4
        )]
		[string] $AttributeName,
        [Parameter(
            ParameterSetName='single',
            Mandatory,
            Position=5
        )]
		[string] $AttributeValue,
        [Parameter(
            ParameterSetName='list',
            Mandatory,
            Position=5
        )]
		[string[]] $AttributeValueList
	)

	Begin {
        if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)
		}

        if($AttributeValueList.Count -gt 5) {
            throw "Too many Attribute Ids provided. Max 5 supported by API, you entered `"$($AttributeValueList.count)`"."
        }
        elseif ($AttributeValueList.Count -gt 0) {
            $AttributeValue = $AttributeValueList -join ','
            $PSBoundParameters.Add('AttributeValue', $AttributeValue)
            $PSBoundParameters.Remove('AttributeValueList') | Out-Null
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
            'AttributeName' = 'attributename'
            'AttributeValue' = 'attributevalue'
		}

		$paramsList = @('whitelisttype=attribute')
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