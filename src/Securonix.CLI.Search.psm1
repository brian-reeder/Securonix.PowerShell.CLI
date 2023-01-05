<#
.DESCRIPTION
Get-SecuronixSearchAPIResponse is a flexible controller used to process Securonix Search calls. Use the higher level interfaces to enforce parameter guidelines.

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
PS> Get-SecuronixSearchAPIResponse -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -query "index=tpi AND tpi_type=`"Malicious Domain`""

.EXAMPLE
PS> Get-SecuronixSearchAPIResponse -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -query "index=activity AND accountname=`"admin`"" -eventtime_from "01/02/2008 00:00:00" -eventtime_to "01/03/2008 00:00:00" -max 10000
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
function Get-SecuronixSearchAPIResponse {
    [CmdletBinding(
        DefaultParameterSetName="default",
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
        [string] $query,

        [Parameter(
            Mandatory,
            ParameterSetName='Activity',
            Position=3
        )]
        [string] $eventtime_from,
        [Parameter(
            Mandatory,
            ParameterSetName='Activity',
            Position=4
        )]
        [string] $eventtime_to,
        [Parameter(
            Mandatory,
            ParameterSetName='Violation',
            Position=4
        )]
        [string] $generationtime_from,
        [Parameter(
            Mandatory,
            ParameterSetName='Violation',
            Position=4
        )]
        [string] $generationtime_to,
        [Parameter(
            ParameterSetName='Activity',
            Position=5
        )]
        [Parameter(
            ParameterSetName='Violation',
            Position=5
        )]
        [string] $tz,
        [Parameter(
            ParameterSetName='Activity',
            Position=6
        )]
        [Parameter(
            ParameterSetName='Violation',
            Position=6
        )]
        [bool] $prettyJson,
        [Parameter(
            ParameterSetName='Activity',
            Position=7
        )]
        [Parameter(
            ParameterSetName='Violation',
            Position=7
        )]
        [int] $max,
        [Parameter(
            ParameterSetName='Activity',
            Position=8
        )]
        [Parameter(
            ParameterSetName='Violation',
            Position=8
        )]
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
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
			$paramsList += "$($param)=$($PSBoundParameters[$param])"
		}
		
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
Get-SecuronixActivityEvents prepares API parameters and queries the Securonix activity index.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER Query
A spotter query to be processed by Securonix. Valid indexes are: activity, violation, users, asset, geolocation, lookup, riskscore, riskscorehistory.

.PARAMETER TimeStart
Required to query the activity index. Enter the event time start range in format MM/dd/yyy HH:mm:ss.

.PARAMETER TimeEnd
Required to query the activity index. Enter the event time end range in format MM/dd/yyy HH:mm:ss.

.PARAMETER TimeZone
Enter the timezone info. If empty, the application timezone will be selected.

.PARAMETER Max
Enter the number of records you want the REST API to return. Default: 1000, Max: 10000.

.PARAMETER QueryId
Used for paginating through the results in the specified duration to ge the next set of maximum records. When you run the query for the first time, the response has the queryId. You can use the queryId to look for records on a specific page.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentAPIResponse

.OUTPUTS
System.String. Get-SecuronixIncidentAPIResponse returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixActivityEvents -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -Query "accountname=`"admin`"" -TimeStart "01/02/2008 00:00:00" -TimeEnd "01/03/2008 00:00:00" -Max 10000
.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Activity
#>
function Get-SecuronixActivityEvents {
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
        [string] $TimeStart,
        [Parameter(Mandatory)]
        [string] $TimeEnd,

        [AllowEmptyString()]
        [string] $Query = '',

        [string] $TimeZone,
        [bool] $PrettyJson,
        [int] $Max,
        [string] $QueryId
	)

	Begin {
		$paramsTable = @{
            'Query' = 'query'
			'TimeStart' = 'eventtime_from'
			'TimeEnd' = 'eventtime_to'
			'TimeZone' = 'tz'
			'PrettyJson' = 'prettyJson'
			'Max' = 'max'
			'QueryId' = 'queryId'
		}

        $Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        if($Query -ne '') {
            $PSBoundParameters['Query'] = "index=activity AND $($Query)"
        }
        else {
            $PSBoundParameters['Query'] = 'index=activity'
        }

		$params = [ordered]@{}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
        $r = Get-SecuronixSearchAPIResponse @Params
        return $r
	}

	End {}
}

<#
.DESCRIPTION
Get-SecuronixAssetData prepares API parameters and queries the Securonix asset index.

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
PS> Get-SecuronixAssetData -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF"

.EXAMPLE
PS> GetSecuronixAssetData -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -Query "entityname=`"QUALYYSTEST|30489654_42428`""

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Asset
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
		$paramsTable = @{
            'Query' = 'query'
		}

        $Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        if($Query -ne '') {
            $PSBoundParameters['Query'] = "index=asset AND $($Query)"
        }
        else {
            $PSBoundParameters['Query'] = 'index=asset'
        }

		$params = [ordered]@{}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
        $r = Get-SecuronixSearchAPIResponse @Params
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
PS> Get-SecuronixGeolocationData -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF"

.EXAMPLE
PS> Get-SecuronixGeolocationData -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -Query "location = `"City:Paris Region:A8 Country:FR`" AND longitude = `"2.3488`""

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Geolocation
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
		$paramsTable = @{
            'Query' = 'query'
		}

        $Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        if($Query -ne '') {
            $PSBoundParameters['Query'] = "index=geolocation AND $($Query)"
        }
        else {
            $PSBoundParameters['Query'] = 'index=geolocation'
        }

		$params = [ordered]@{}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
        $r = Get-SecuronixSearchAPIResponse @Params
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
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Lookup
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
		$paramsTable = @{
            'Query' = 'query'
		}

        $Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        if($Query -ne '') {
            $PSBoundParameters['Query'] = "index=lookup AND $($Query)"
        }
        else {
            $PSBoundParameters['Query'] = 'index=lookup'
        }

		$params = [ordered]@{}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
        $r = Get-SecuronixSearchAPIResponse @Params
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
PS> Get-SecuronixRiskScorecard -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF"

.EXAMPLE
PS> Get-SecuronixRiskScorecard -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -Query "violator = `"Users`" AND employeeid = `"1082`""

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#RiskHistory
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
		$paramsTable = @{
            'Query' = 'query'
		}

        $Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        if($Query -ne '') {
            $PSBoundParameters['Query'] = "index=riskscore AND $($Query)"
        }
        else {
            $PSBoundParameters['Query'] = 'index=riskscore'
        }

		$params = [ordered]@{}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
        $r = Get-SecuronixSearchAPIResponse @Params
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
PS> Get-SecuronixRiskHistory -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF"

.EXAMPLE
PS> Get-SecuronixRiskHistory -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -Query "employeeid = `"1129`""

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#RiskHistory
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
		$paramsTable = @{
            'Query' = 'query'
		}

        $Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        if($Query -ne '') {
            $PSBoundParameters['Query'] = "index=riskscorehistory AND $($Query)"
        }
        else {
            $PSBoundParameters['Query'] = 'index=riskscorehistory'
        }

		$params = [ordered]@{}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
        $r = Get-SecuronixSearchAPIResponse @Params
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
PS> Get-SecuronixTPI -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF"

.EXAMPLE
PS> Get-SecuronixTPI -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -Query "tpi_type = `"Malicious Domain`""

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#ThirdPartyIntel
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
		$paramsTable = @{
            'Query' = 'query'
		}

        $Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        if($Query -ne '') {
            $PSBoundParameters['Query'] = "index=tpi AND $($Query)"
        }
        else {
            $PSBoundParameters['Query'] = 'index=tpi'
        }

		$params = [ordered]@{}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
        $r = Get-SecuronixSearchAPIResponse @Params
        return $r
	}

	End {}
}

<#
.DESCRIPTION
Get-SecuronixUsersData prepares API parameters and queries the Securonix tpi index.

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
PS> Get-SecuronixUsersData -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF"

.EXAMPLE
PS> Get-SecuronixUsersData -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -Query "location = `"Dallas`" AND lastname = `"OGWA`""

.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Users
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
		$paramsTable = @{
            'Query' = 'query'
		}

        $Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        if($Query -ne '') {
            $PSBoundParameters['Query'] = "index=users AND $($Query)"
        }
        else {
            $PSBoundParameters['Query'] = 'index=users'
        }

		$params = [ordered]@{}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
        $r = Get-SecuronixSearchAPIResponse @Params
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
Required to query the violation index. Enter the event time start range in format MM/dd/yyy HH:mm:ss.

.PARAMETER TimeEnd
Required to query the violation index. Enter the event time end range in format MM/dd/yyy HH:mm:ss.

.PARAMETER TimeZone
Enter the timezone info. If empty, the application timezone will be selected.

.PARAMETER Max
Enter the number of records you want the REST API to return. Default: 1000, Max: 10000.

.PARAMETER QueryId
Used for paginating through the results in the specified duration to ge the next set of maximum records. When you run the query for the first time, the response has the queryId. You can use the queryId to look for records on a specific page.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentAPIResponse

.OUTPUTS
System.String. Get-SecuronixIncidentAPIResponse returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixViolationEvents -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -Query "policyname=`"Email sent to self`"" -TimeStart "01/02/2008 00:00:00" -TimeEnd "01/02/2008 15:00:00" -Max 50
.LINK
https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#Violations
#>
function Get-SecuronixViolationEvents {
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
        [string] $TimeStart,
        [Parameter(Mandatory)]
        [string] $TimeEnd,

        [AllowEmptyString()]
        [string] $Query = '',

        [string] $TimeZone,
        [bool] $PrettyJson,
        [int] $Max,
        [string] $QueryId
	)

	Begin {
		$paramsTable = @{
            'Query' = 'query'
			'TimeStart' = 'generationtime_from'
			'TimeEnd' = 'generationtime_to'
			'TimeZone' = 'tz'
			'PrettyJson' = 'prettyJson'
			'Max' = 'max'
			'QueryId' = 'queryId'
		}

        $Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        if($Query -ne '') {
            $PSBoundParameters['Query'] = "index=violation AND $($Query)"
        }
        else {
            $PSBoundParameters['Query'] = 'index=violation'
        }

		$params = [ordered]@{}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
        $r = Get-SecuronixSearchAPIResponse @Params
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
PS> Get-SecuronixWatchlistData -Url 'hxxps://DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'

.EXAMPLE
PS> Get-SecuronixWatchlistData -Url 'hxxps://DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Query 'watchlistname="Flight Risk Users"'

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
		$paramsTable = @{
            'Query' = 'query'
		}

        $Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        if($Query -ne '') {
            $PSBoundParameters['Query'] = "index=watchlist AND $($Query)"
        }
        else {
            $PSBoundParameters['Query'] = 'index=watchlist'
        }

		$params = [ordered]@{}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$params[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
        $r = Get-SecuronixSearchAPIResponse @Params
        return $r
	}

	End {}
}