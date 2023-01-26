<#
.DESCRIPTION
Get-SecuronixEntityThreatDetails prepares API parameters and queries the Securonix API for a list of all threats violated in a time range.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER DocumentId
A required API Parameter, enter a RiskScore document ID.

.PARAMETER TenantName
Enter the name of the tenant the threat model belongs to. This parameter is optional for non-MSSP.

.INPUTS
None. You cannot pipe objects to Get-SecuronixEntityThreatDetails

.OUTPUTS
System.String. Get-SecuronixEntityThreatDetails returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixEntityThreatDetails -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -DocumentId '2^~A^~7|NULL|AW2385^~C^~1^~EP^~66)'

.EXAMPLE
PS> Get-SecuronixEntityThreatDetails -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -DocumentId '2^~A^~7|NULL|AW2385^~C^~1^~EP^~66)' -TenantName 'PA-Scranton'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Security%20Command%20Center/Get-SecuronixEntityThreatDetails.md
#>
function Get-SecuronixEntityThreatDetails {
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
		[string] $DocumentId,

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
            'DocumentId' = 'docid'
            'TenantName' = 'tenantname'
		}

		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/sccWidget/getEntityThreatDetail?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response.Response.threats
        }
	}

	End {}
}