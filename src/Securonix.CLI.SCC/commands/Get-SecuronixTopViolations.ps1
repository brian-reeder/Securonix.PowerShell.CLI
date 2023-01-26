<#
.DESCRIPTION
Get-SecuronixTopViolations prepares API parameters and queries the Securonix API for a list of the Top violations in the Security Command Center.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER Days
The number of days to search for threats.

.PARAMETER Hours
The number of hours to search for threats.

.PARAMETER Offset
An optional API Parameter, used for pagination of the request.

.PARAMETER Max
An optional API Parameter, enter maximum number of records the API will display.

.INPUTS
None. You cannot pipe objects to Get-SecuronixTopViolations

.OUTPUTS
System.String. Get-SecuronixTopViolations returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixTopViolations -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Hours 12

.EXAMPLE
PS> Get-SecuronixTopViolations -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Days 90 -Max 100

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Security%20Command%20Center/Get-SecuronixTopViolations.md
#>
function Get-SecuronixTopViolations {
    [CmdletBinding(
        DefaultParameterSetName='days',
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
            ParameterSetName='days',
            Mandatory,
            Position=2
        )]
		[int] $Days,
        [Parameter(
            ParameterSetName='hours',
            Mandatory,
            Position=2
        )]
		[int] $Hours,
        [int] $Offset = 0,
		[int] $Max    = 10
	)

	Begin {
        if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

        $PSBoundParameters['Offset'] = $Offset
        $PSBoundParameters['Max']    = $Max

		$Header = [ordered]@{
			'token' = $Token
		}

        $Exclusions = @('Url', 'Token', 'WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        $dateunit = 'days'
        $dateunitvalue = 1
        if($PSBoundParameters.Keys -contains 'Days') {
            $dateunit = 'days'
            $dateunitvalue = $PSBoundParameters['Days']
            $PSBoundParameters.Remove('Days')
        }
        
        if($PSBoundParameters.Keys -contains 'Hours') {
            $dateunit = 'hours'
            $dateunitvalue = $PSBoundParameters['Hours']
            $PSBoundParameters.Remove('Hours')
        }

        $PSBoundParameters.add('dateunit', $dateunit)
        $PSBoundParameters.add('dateunitvalue', $dateunitvalue)

        $paramsTable = @{
            'Offset' = 'offset'
            'Max' = 'max'
		}

		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/sccWidget/getTopViolations?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response.Response.Docs
        }
	}

	End {}
}