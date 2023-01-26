<#
.DESCRIPTION
New-SecuronixIncident makes an API call to the Incident/Actions endpoint and creates a new incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter. Enter the incident id of the incident to update.

.PARAMETER ViolationName
A required API Parameter. Enter the violation policy name.

.PARAMETER DatasourceName
A required API Parameter. Enter the resource group name.

.PARAMETER EntityType
A required API Parameter. Enter any of the following types: Users, Activityaccount, RGActivityaccount, Resources, Activityip.

.PARAMETER EntityName
A required API Parameter. Enter the accountname associated with the violation.

.PARAMETER Workflow
A required API Parameter. Enter the workflow name.

.PARAMETER Comment
An optional API Parameter. Enter an additional comment.

.PARAMETER EmployeeId
An optional API Parameter. Enter the employee id.

.PARAMETER Criticality
A required parameter. Enter the new criticality. Possible values: 'none','low','medium','high','custom'.

.INPUTS
None. You cannot pipe objects to New-SecuronixIncident

.OUTPUTS
System.String. New-SecuronixIncident returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> New-SecuronixIncident -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -ViolationName 'Repeated Visits to Potentially Malicious address' -DatasourceName 'Websense Proxy' -EntityType 'Activityip' -EntityName '134.119.189.29' -Workflow 'SOCTeamReview'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/New-SecuronixIncident.md
#>
function New-SecuronixIncident {
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
		[string] $ViolationName,
		[Parameter(Mandatory,Position=3)]
		[string] $DatasourceName,
		[Parameter(Mandatory,Position=4)]
		[ValidateSet('Users','Activityaccount','RGActivityaccount','Resources','Activityip')]
		[string] $EntityType,
		[Parameter(Mandatory,Position=5)]
		[string] $EntityName,
		[Parameter(Mandatory,Position=6)]
		[string] $Workflow,

		[string] $Comment,
		[string] $EmployeeId,
		[ValidateSet('none','low','medium','high','custom')]
		[string] $Criticality

	)

	Begin {		
		$Exclusions = @('Url','Token','WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
		}

		$AttrsTable = @{
			'Comment' = 'comment'
			'Criticality' = 'criticality'
			'EmployeeId' = 'employeeId'
			'DatasourceName' = 'datasourceName'
			'EntityType' = 'entityType'
			'EntityName' = 'entityName'
			'ResourceName' = 'resourceName'
			'ViolationName' = 'violationName'

		}
		$Attributes = [ordered]@{}
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($AttrsTable.Keys -Contains $param) { $AttrsTable[$param] } else { $param }
			$Attributes[$key] = $PSBoundParameters[$param]
		}
	}

	Process {
		$r = Update-SecuronixIncident -Url $Url -Token $Token -ActionName 'Mark as concern and create incident' -Attributes $Attributes
		return $r
	}

	End {}
}