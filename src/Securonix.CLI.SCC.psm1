<#
.DESCRIPTION
Get-SecuronixThreats prepares API parameters and queries the Securonix for a list of all threats violated in a time range.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER TimeStart
A required API Parameter, enter starting point for the search. Time (epoch) in ms.

.PARAMETER TimeEnd
A required API Parameter, enter ending point for the search. Time (epoch) in ms.

.PARAMETER Offset
An optional API Parameter, used for pagination of the request.

.PARAMETER Max
An optional API Parameter, enter maximum number of records the API will display.

.PARAMETER TenantName
Enter the name of the tenant the threat model belongs to. This parameter is optional for non-MSSP.

.INPUTS
None. You cannot pipe objects to Get-SecuronixThreats

.OUTPUTS
System.String. Get-SecuronixThreats returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixThreats -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -TimeStart 299721600 -TimeEnd 299807999

.EXAMPLE
PS> Get-SecuronixThreats -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -TimeStart 299721600 -TimeEnd 299807999 -TenantName 'PA-Scranton'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Security%20Command%20Center/Get-SecuronixThreats.md
#>
function Get-SecuronixThreats {
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

		[int] $Offset,
		[int] $Max,
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
			'TimeStart' = 'datefrom'
			'TimeEnd' = 'dateto'
            'Offset' = 'offset'
			'Max' = 'max'
            'TenantName' = 'tenantname'
		}

		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/sccWidget/GetThreats?$($paramsList -join '&')"
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
            return $response
        }
	}

	End {}
}

<#
.DESCRIPTION
Get-SecuronixTopThreats prepares API parameters and queries the Securonix API for a list of the Top threats in the Security Command Center.

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
None. You cannot pipe objects to Get-SecuronixTopThreats

.OUTPUTS
System.String. Get-SecuronixTopThreats returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixTopThreats -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Hours 12

.EXAMPLE
PS> Get-SecuronixTopThreats -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Days 90 -Max 100

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Security%20Command%20Center/Get-SecuronixTopThreats.md
#>
function Get-SecuronixTopThreats {
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
        [int] $Offset,
		[int] $Max
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
		
		$Uri = "$Url/ws/sccWidget/getTopThreats?$($paramsList -join '&')"
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
        [int] $Offset,
		[int] $Max
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
            return $response
        }
	}

	End {}
}

<#
.DESCRIPTION
Get-SecuronixTopViolators prepares API parameters and queries the Securonix API for a list of the Top violators in the Security Command Center.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER Days
The number of days to search for violators.

.PARAMETER Hours
The number of hours to search for violators.

.PARAMETER Offset
An optional API Parameter, used for pagination of the request.

.PARAMETER Max
An optional API Parameter, enter maximum number of records the API will display.

.INPUTS
None. You cannot pipe objects to Get-SecuronixTopViolators

.OUTPUTS
System.String. Get-SecuronixTopViolators returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixTopViolators -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Hours 12

.EXAMPLE
PS> Get-SecuronixTopViolators -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -Days 90 -Max 100

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Security%20Command%20Center/Get-SecuronixTopViolators.md
#>
function Get-SecuronixTopViolators {
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
        [int] $Offset,
		[int] $Max,
        [string] $Name
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
		
		$Uri = "$Url/ws/sccWidget/getTopViolators?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}