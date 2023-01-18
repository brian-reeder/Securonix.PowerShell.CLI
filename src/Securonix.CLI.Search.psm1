<#
.DESCRIPTION
Invoke-SecuronixSearchApi is a flexible controller used to process Securonix Search calls. Use the higher level interfaces to enforce parameter guidelines.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER query
A spotter query to be processed by Securonix. Valid indexes are: activity, violation, users, asset, geolocation, lookup, riskscore, riskscorehistory.

.PARAMETER eventtime_from
Required to query the activity index. Enter the event time start range in format MM/dd/yyy HH:mm:ss.

.PARAMETER eventtime_to
Required to query the activity index. Enter the event time end range in format MM/dd/yyy HH:mm:ss.

.PARAMETER generationtime_from
Required to query the violation index. Enter the event time start range in format MM/dd/yyy HH:mm:ss.

.PARAMETER generationtime_to
Required to query the violation index. Enter the event time end range in format MM/dd/yyy HH:mm:ss.

.PARAMETER tz
Enter the timezone info. If empty, the application timezone will be selected.

.PARAMETER max
Enter the number of records you want the REST API to return. Default: 1000, Max: 10000.

.PARAMETER queryId
Used for paginating through the results in the specified duration to ge the next set of maximum records. When you run the query for the first time, the response has the queryId. You can use the queryId to look for records on a specific page.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentAPIResponse

.OUTPUTS
System.String. Get-SecuronixIncidentAPIResponse returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Invoke-SecuronixSearchApi -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -query "index=tpi AND tpi_type=`"Malicious Domain`""

.EXAMPLE
PS> Invoke-SecuronixSearchApi -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -query "index=activity AND accountname=`"admin`"" -eventtime_from "01/02/2008 00:00:00" -eventtime_to "01/03/2008 00:00:00" -max 10000
.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Activity

https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Asset

https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Geolocation

https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Lookup

https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#RiskHistory

https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#ThirdPartyIntel

https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Users

https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Violations
#>
function Invoke-SecuronixSearchApi {
    [CmdletBinding(
        DefaultParameterSetName="default",
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token,
        [Parameter(Mandatory)]
        [string] $query,

        [Parameter(Mandatory,ParameterSetName='Activity')]
        [string] $eventtime_from,
        [Parameter(Mandatory,ParameterSetName='Activity')]
        [string] $eventtime_to,
        [Parameter(Mandatory,ParameterSetName='Violation')]
        [string] $generationtime_from,
        [Parameter(Mandatory,ParameterSetName='Violation')]
        [string] $generationtime_to,
        [Parameter(ParameterSetName='Activity')]
        [Parameter(ParameterSetName='Violation')]
        [string] $tz,
        [Parameter(ParameterSetName='Activity')]
        [Parameter(ParameterSetName='Violation')]
        [int] $max,
        [Parameter(ParameterSetName='Activity')]
        [Parameter(ParameterSetName='Violation')]
        [string] $queryId
 	)

	Begin {
		if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

        $Exclusions = @('Url', 'Token', 'WhatIf', 'Confirm', 'Verbose')

        $paramsList = $PSBoundParameters.GetEnumerator() `
            | Where-Object { $Exclusions -notcontains $_.Key } `
            | ForEach-Object { "$($_.Key)=$($_.Value)" }
		
		$Uri = "$Url/ws/spotter/index/search?$($paramsList -join '&')"
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
Get-SecuronixActivityEvents prepares API parameters and queries the Securonix activity index. If any events are matched, they will be returned by the API in groups of 1000 if Max is not supplied.

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
None. You cannot pipe objects to Get-SecuronixActivityEvents

.OUTPUTS
System.String. Get-SecuronixActivityEvents returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixActivityEvents -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -TimeStart "01/02/2008 00:00:00" -TimeEnd "01/03/2008 00:00:00" -Query 'accountname="admin"' -Max 10000
.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Search/Get-SecuronixActivityEvents.md
#>
function Get-SecuronixActivityEvents {
    [CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
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
        . "$PSScriptRoot\lib\Convert-StringTime.ps1"
        . "$PSScriptRoot\lib\Format-ApiParameters.ps1"

        $PSBoundParameters['TimeStart'] = Convert-StringTime -InputDateTime $TimeStart -OutDateTime
        $PSBoundParameters['TimeEnd']   = Convert-StringTime -InputDateTime $TimeEnd -OutDateTime

        $PSBoundParameters['Query'] = "index=activity$(if($Query -ne '') { " AND $Query" })"

		$params = Format-ApiParameters -ParameterSet $PSBoundParameters `
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
        return $r
	}

	End {}
}

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
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token,

        [AllowEmptyString()]
        [string] $Query = ''
	)

	Begin {
        . "$PSScriptRoot\lib\Format-ApiParameters.ps1"

        $PSBoundParameters['Query'] = "index=asset$(if($Query -ne '') { " AND $Query" })"

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
        . "$PSScriptRoot\lib\Format-ApiParameters.ps1"

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

<#
.DESCRIPTION
Get-SecuronixLookupData prepares API parameters and queries the Securonix lookup index.

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
PS> Get-SecuronixLookupData -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF"

.EXAMPLE
PS> Get-SecuronixLookupData -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -Query "lookupname = `"VulnerableHostLookUpTable`""

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Search/Get-SecuronixLookupData.md
#>
function Get-SecuronixLookupData {
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
        . "$PSScriptRoot\lib\Format-ApiParameters.ps1"

        $PSBoundParameters['Query'] = "index=lookup$(if($Query -ne '') { " AND $Query" })"

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

<#
.DESCRIPTION
Get-SecuronixRiskScorecard prepares API parameters and queries the Securonix riskscore index.

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
PS> Get-SecuronixRiskScorecard -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Query 'violator = "Users" AND employeeid = "1082"'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Search/Get-SecuronixRiskScorecard.md
#>
function Get-SecuronixRiskScorecard {
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
        . "$PSScriptRoot\lib\Format-ApiParameters.ps1"

        $PSBoundParameters['Query'] = "index=riskscore$(if($Query -ne '') { " AND $Query" })"

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
        . "$PSScriptRoot\lib\Format-ApiParameters.ps1"

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

<#
.DESCRIPTION
Get-SecuronixTPI prepares API parameters and queries the Securonix tpi index.

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
PS> Get-SecuronixTPI -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Query 'tpi_type = "Malicious Domain"'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Search/Get-SecuronixRiskHistory.md
#>
function Get-SecuronixTPI {
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
        . "$PSScriptRoot\lib\Format-ApiParameters.ps1"

        $PSBoundParameters['Query'] = "index=tpi$(if($Query -ne '') { " AND $Query" })" 

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

<#
.DESCRIPTION
Get-SecuronixUsersData prepares API parameters and queries the Securonix users index.

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
Get-SecuronixUsersData -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Query 'location = "Dallas" AND lastname = "OGWA"'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Search/Get-SecuronixUsersData.md
#>
function Get-SecuronixUsersData {
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
        . "$PSScriptRoot\lib\Format-ApiParameters.ps1"

        $PSBoundParameters['Query'] = "index=users$(if($Query -ne '') { " AND $Query" })" 

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

<#
.DESCRIPTION
Get-SecuronixViolationEvents prepares API parameters and queries the Securonix violation index.

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
None. You cannot pipe objects to Get-SecuronixViolationEvents

.OUTPUTS
System.String. Get-SecuronixViolationEvents returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixViolationEvents -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Query 'policyname="Email sent to self"'
.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Search/Get-SecuronixViolationEvents.md
#>
function Get-SecuronixViolationEvents {
    [CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
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
        . "$PSScriptRoot\lib\Format-ApiParameters.ps1"
        . "$PSScriptRoot\lib\Convert-StringTime.ps1"

		$PSBoundParameters['TimeStart'] = Convert-StringTime -InputDateTime $TimeStart -OutDateTime
        $PSBoundParameters['TimeEnd']   = Convert-StringTime -InputDateTime $TimeEnd -OutDateTime

        $PSBoundParameters['Query'] = "index=violation$(if($Query -ne '') { " AND $Query" })" 

        $params = Format-ApiParameters -ParameterSet $PSBoundParameters `
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

<#
.DESCRIPTION
Get-SecuronixWatchlistData prepares API parameters and queries the Securonix watchlist index.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER Query
A spotter query to be processed by Securonix. Valid indexes are: activity, violation, users, asset, geolocation, lookup, riskscore, riskscorehistory.

.INPUTS
None. You cannot pipe objects to Get-SecuronixWatchlistData

.OUTPUTS
System.String. Get-SecuronixWatchlistData returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixWatchlistData -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Query 'watchlistname="Flight Risk Users"'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Search/Get-SecuronixWatchlistData.md
#>
function Get-SecuronixWatchlistData {
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
        . "$PSScriptRoot\lib\Format-ApiParameters.ps1"

        $PSBoundParameters['Query'] = "index=watchlist$(if($Query -ne '') { " AND $Query" })" 

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