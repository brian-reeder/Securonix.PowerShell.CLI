<#
.DESCRIPTION
Get-SecuronixActivityEventsList prepares API parameters and queries the Securonix activity index. If any events are matched, they will be returned by the API in groups of 1000 if Max is not supplied.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER Query
A spotter query to be processed by Securonix. Valid indexes are: activity, violation, users, asset, geolocation, lookup, riskscore, riskscorehistory.

.PARAMETER TimeStart
Required to query the activity index. Enter the event time start range. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS'.

.PARAMETER TimeEnd
Required to query the activity index. Enter the event time start range. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS'.

.PARAMETER TimeZone
Enter the timezone info. If empty, the application timezone will be selected.

.PARAMETER Max
Enter the number of records you want the REST API to return. Default: 1000, Max: 10000.

.PARAMETER QueryId
Used for paginating through the results in the specified duration to ge the next set of maximum records. When you run the query for the first time, the response has the queryId. You can use the queryId to look for records on a specific page.

.INPUTS
None. You cannot pipe objects to Get-SecuronixActivityEventsList

.OUTPUTS
System.String. Get-SecuronixActivityEventsList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixActivityEventsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -TimeStart "01/02/2008 00:00:00" -TimeEnd "01/03/2008 00:00:00" -Query 'accountname="admin"' -Max 10000
.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Search/Get-SecuronixActivityEventsList.md
#>
function Get-SecuronixActivityEventsList {
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

        $PSBoundParameters['Query'] = "index=activity$(if($Query -ne '') { " AND $Query" })"

		$params = Format-ApiParameterSet -ParameterSet $PSBoundParameters `
            -Exclusions @('WhatIf', 'Confirm', 'Verbose') `
            -Aliases @{
                'Query' = 'query'
                'TimeStart' = 'eventtime_from'
                'TimeEnd' = 'eventtime_to'
                'TimeZone' = 'tz'
                'Max' = 'max'
                'QueryId' = 'queryId'
            }
	}

	Process {
        $r = Invoke-SecuronixSearchApi @params
        return $r.events
	}

	End {}
}