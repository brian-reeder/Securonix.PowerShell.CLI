<#
.DESCRIPTION
Add-SecuronixViolationScore makes an API call to the Incident/Actions endpoint and updates an incident with the supplied action.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER ScoreIcrement
A required API parameter. Only accepts positive integers, enter the value to increase the violation score by.

.PARAMETER TenantName
A required API parameter. The name of the tenant the entity belongs to.

.PARAMETER ViolationName
A required API parameter. Name of the violation/policy to increase the violation score.

.PARAMETER PolicyCategory
A required API parameter. Policy category name of the policy being acted on.

.PARAMETER EntityType
A required API parameter. Type of entity, enter any of: Users, Activityaccount, Resources, IpAddress.

.PARAMETER EntityName
A required API parameter. Entityid/name of the entity being added. accountname for Activityaccount, userid for Users, ipadress for ActivityIp, resourceName for resources.

.PARAMETER ResourceGroupName
Required if EntityType is not Users. Enter the name of the resource group the entity belongs to.

.PARAMETER ResourceName
Required if EntityType is not Users. Enter the name of the resource the entity belongs to.

.INPUTS
None. You cannot pipe objects to Add-SecuronixViolationScore

.OUTPUTS
System.String. Add-SecuronixViolationScore returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Add-SecuronixViolationScore -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -ScoreIncrement 1 -TenantName 'Automationtenant' -ViolationName 'policy' -PolicyCategory 'category' -EntityType 'Users' -EntityName 'xyz' -ResourceGroupname 'rgGroup' -ResourceName 'resource'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Add-SecuronixViolationScore.md
#>
function Add-SecuronixViolationScore {
	[CmdletBinding(
		DefaultParameterSetName='default',
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory,Position=0)]
		[string] $Url,
		[Parameter(Mandatory,Position=1)]
		[string] $Token,
		[Parameter(Mandatory,Position=2)]
		[int] $ScoreIncrement,
		[Parameter(Mandatory,Position=3)]
		[string] $TenantName,
		[Parameter(Mandatory,Position=4)]
		[string] $ViolationName,
		[Parameter(Mandatory,Position=5)]
		[string] $PolicyCategory,
		[Parameter(Mandatory,Position=6)]
		[ValidateSet('Users','Activityaccount','RGActivityaccount','Resources','Activityip')]
		[string] $EntityType,
		[Parameter(Mandatory,Position=7)]
		[string] $EntityName,
		[Parameter(Mandatory,Position=8)]
		[string] $ResourceGroupName,
		[Parameter(Mandatory,Position=9)]
		[string] $ResourceName
	)

	Begin {
		if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

		$Exclusions = @(
			'Url', 'Token', 'WhatIf', 'Confirm', 'Verbose'
		)
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }
		
		$paramsTable = @{
			'ScoreIcrement' = 'scoreIncrement'
			'TenantName' = 'tenantname'
			'ViolationName' = 'violationName'
			'PolicyCategory' = 'policyCategory'
			'EntityType' = 'entityType'
			'EntityName' = 'entityName'
			'ResourceGroupName' = 'resourcegroupName'
			'ResourceName' = 'resourceName'
		}
		
		$params = @()
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$value = $PSBoundParameters[$param]
			$params += "$key=$value"
		}
		
		$Uri = "$Url/ws/incident/updateViolationScore?$($params -join '&')"
	}

	Process {
		if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
			$response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
			return $response
		}
	}


	End {}
}