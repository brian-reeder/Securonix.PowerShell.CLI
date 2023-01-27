<#
.DESCRIPTION
Get-SecuronixRiskHistory prepares API parameters and queries the Securonix riskscorehistory index.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER Query
A spotter query to be processed by Securonix. Valid indexes are: activity, violation, users, asset, geolocation, lookup, riskscore, riskscorehistory.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentAPIResponse

.OUTPUTS
System.String. Get-SecuronixIncidentAPIResponse returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixRiskHistory -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Query 'employeeid = "1129"'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Search/Get-SecuronixRiskHistory.md
#>
function Get-SecuronixRiskHistory {
    [CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token,

        [AllowEmptyString()]
        [string] $Query = ''
	)

    Begin {
        $PSBoundParameters['Query'] = "index=riskscorehistory$(if($Query -ne '') { " AND $Query" })" 

        $params = Format-ApiParameters -ParameterSet $PSBoundParameters `
            -Exclusions @('WhatIf', 'Confirm', 'Verbose') `
            -Aliases @{
                'Query' = 'query'
            }
	}

	Process {
        $r = Invoke-SecuronixSearchApi @Params
        return $r
	}

	End {}
}