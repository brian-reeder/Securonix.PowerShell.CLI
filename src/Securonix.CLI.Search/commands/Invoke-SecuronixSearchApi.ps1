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