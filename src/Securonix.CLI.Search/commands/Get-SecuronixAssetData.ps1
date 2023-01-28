<#
.DESCRIPTION
Get-SecuronixAssetData prepares API parameters and queries the Securonix activity index. If any events are matched, they will be returned by the API in groups of 1000 if Max is not supplied.

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
PS> GetSecuronixAssetData -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Query 'entityname="QUALYYSTEST|30489654_42428"'

.EXAMPLE
PS> Get-SecuronixAssetData -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Search/Get-SecuronixAssetData.md
#>
function Get-SecuronixAssetData {
    [CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSShouldProcess', '',
        Scope='Function',
        Justification='ShouldProcess is handled by the function Invoke-SecuronixSearchApi'
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
        $PSBoundParameters['Query'] = "index=asset$(if($Query -ne '') { " AND $Query" })"

        $params = Format-ApiParameterSet -ParameterSet $PSBoundParameters `
            -Exclusions @('WhatIf', 'Confirm', 'Verbose') `
            -Aliases @{
                'Query' = 'query'
            }
	}

	Process {
        $r = Invoke-SecuronixSearchApi @Params
        return $r.events.result.entry
	}

	End {}
}