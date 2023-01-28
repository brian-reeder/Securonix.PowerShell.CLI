<#
.DESCRIPTION
Get-SecuronixViolationEventsList prepares API parameters and queries the Securonix violation index.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER Query
A spotter query to be processed by Securonix. Valid indexes are: activity, violation, users, asset, geolocation, lookup, riskscore, riskscorehistory.

.PARAMETER TimeStart
Required to query the violation index. Enter the event time start range. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS'.

.PARAMETER TimeEnd
Required to query the violation index. Enter the event time end range. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS'.

.PARAMETER TimeZone
Enter the timezone info. If empty, the application timezone will be selected.

.PARAMETER Max
Enter the number of records you want the REST API to return. Default: 1000, Max: 10000.

.PARAMETER QueryId
Used for paginating through the results in the specified duration to ge the next set of maximum records. When you run the query for the first time, the response has the queryId. You can use the queryId to look for records on a specific page.

.INPUTS
None. You cannot pipe objects to Get-SecuronixViolationEventsList

.OUTPUTS
System.String. Get-SecuronixViolationEventsList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixViolationEventsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Query 'policyname="Email sent to self"'
.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Search/Get-SecuronixViolationEventsList.md
#>
function Get-SecuronixViolationEventsList {
    [CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSShouldProcess', '',
        Scope='Function',
        Justification='ShouldProcess is handled by the function Invoke-SecuronixSearchApi'
    )]
	param(
		[Parameter(Mandatory,Position=0)]
		[string] $Url,
		[Parameter(Mandatory,Position=1)]
		[string] $Token,
        [Parameter(Mandatory,Position=2)]
        [string] $TimeStart,
        [Parameter(Mandatory,Position=3)]
        [string] $TimeEnd,

        [Parameter(Position=4)]
        [AllowEmptyString()]
        [string] $Query = '',

        [string] $TimeZone,
        [int] $Max,
        [string] $QueryId
	)

    Begin {
		$PSBoundParameters['TimeStart'] = Convert-StringTime -InputDateTime $TimeStart -OutDateTime
        $PSBoundParameters['TimeEnd']   = Convert-StringTime -InputDateTime $TimeEnd -OutDateTime

        $PSBoundParameters['Query'] = "index=violation$(if($Query -ne '') { " AND $Query" })"

        $params = Format-ApiParameterSet -ParameterSet $PSBoundParameters `
            -Exclusions @('WhatIf', 'Confirm', 'Verbose') `
            -Aliases @{
                'Query' = 'query'
                'TimeStart' = 'generationtime_from'
                'TimeEnd' = 'generationtime_to'
                'TimeZone' = 'tz'
                'Max' = 'max'
                'QueryId' = 'queryId'
            }
	}

	Process {
        $r = Invoke-SecuronixSearchApi @Params
        return $r
	}

	End {}
}