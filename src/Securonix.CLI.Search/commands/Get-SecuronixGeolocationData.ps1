<#
.DESCRIPTION
Get-SecuronixGeolocationData prepares API parameters and queries the Securonix geolocation index.

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
PS> Get-SecuronixGeolocationData -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Query 'location = "City:Paris Region:A8 Country:FR" AND longitude = "2.3488"'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Search/Get-SecuronixGeolocationData.md
#>
function Get-SecuronixGeolocationData {
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
        $PSBoundParameters['Query'] = "index=geolocation$(if($Query -ne '') { " AND $Query" })"

        params = Format-ApiParameters -ParameterSet $PSBoundParameters `
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