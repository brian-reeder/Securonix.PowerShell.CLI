<#
.DESCRIPTION
Update-SecuronixIncident makes an API call to the Incident/Actions endpoint and updates an incident with the supplied action.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the workflow name.

.PARAMETER ActionName
A required API Parameter. Enter an action that you want to perform for the incident. You can run the Available Threat Actions on an Incident API to view the available actions.

.PARAMETER Attributes
Depending on workflow configured in your organization, add the required attributes. Run Confirm-SecuronixIncidentAction, or Get-SecuronixIncidentActions to view all the attributes (required or not).

.INPUTS
None. You cannot pipe objects to Update-SecuronixIncident

.OUTPUTS
System.String. Update-SecuronixIncident returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Update-SecuronixIncident -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '10029' -ActionName 'comment' -Attributes @{'comment'='comment message';'username'='jhalpert';'firstname'='Jim';'lastname'='Halpert'}

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Update-SecuronixIncident.md
#>
function Update-SecuronixIncident {
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
		[Parameter(ParameterSetName='IncidentId',
			Mandatory,
			Position=2
		)]
		[string] $IncidentId,
		[Parameter(ParameterSetName='bulkcaseids',
			Mandatory
		)]
		[string] $bulkcaseids,
		[Parameter(ParameterSetName='bulkcaseidsList',
			Mandatory
		)]
		[string[]] $bulkcaseidsList,
		[Parameter(Mandatory,Position=2)]
		[string] $ActionName,
		
		[hashtable] $Attributes
	)

	Begin {
		if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

		if($bulkcaseids -ne '') {
			$bulkcaseids = "bulkcaseids=$bulkcaseids"
		}
		if($bulkcaseidsList.Count -gt 0) {
			$list = @()
			foreach($i in $bulkcaseidsList) {
				$list += "bulkcaseids=$i"
			}
			$bulkcaseids = ($list -join '&')
			$PSBoundParameters.Remove('bulkcaseidsList') | Out-Null
		}

		foreach($key in $Attributes.Keys) {
			$PSBoundParameters.Add($key, $Attributes[$key])
		}

		$Exclusions = @(
			'Url', 'Token', 'WhatIf', 'Confirm', 'Verbose',
			'Attributes', 'bulkcaseids'
		)
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }
		###
		$paramsTable = @{
			'IncidentId' = 'incidentId'
			'ActionName' = 'actionName'
		}
		
		$params = @()
		foreach($param in $PSBoundParameters.Keys) {
			$key = if($paramsTable.Keys -Contains $param) { $paramsTable[$param] } else { $param }
			$value = $PSBoundParameters[$param]
			$params += "$key=$value"
		}
		###
		$Uri = "$Url/ws/incident/actions?$($params -join '&')"

		if($bulkcaseids -ne '') {
			$Uri = "$Uri&$bulkcaseids"
		}
	}

	Process {
		if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
			$response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
			return $response
		}
	}


	End {}
}