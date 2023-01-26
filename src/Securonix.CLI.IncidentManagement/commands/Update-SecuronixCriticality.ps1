<#
.DESCRIPTION
Update-SecuronixCriticality makes an API call to the Incident/Actions endpoint and updates the incidents criticality.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter. Enter the incident id of the incident to update.

.PARAMETER Criticality
A required parameter. Enter the new criticality. Possible values: 'none','low','medium','high','custom'.

.INPUTS
None. You cannot pipe objects to Update-SecuronixCriticality

.OUTPUTS
System.String. Update-SecuronixCriticality returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Update-SecuronixCriticality -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '10029' -Criticality 'high'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Update-SecuronixCriticality.md
#>
function Update-SecuronixCriticality {
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
		[string] $IncidentId,
		[Parameter(Mandatory,Position=3)]
		[ValidateSet('none','low','medium','high','custom')]
		[string] $Criticality
	)

	Begin {		
		$Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
		}

		$Attributes = @{}
		$Attributes.Add('criticality', $Criticality)
		$Attributes.Add('changecriticality', 'true')


	}

	Process {
		$r = Update-SecuronixIncident -Url $Url -Token $Token -IncidentId $IncidentId -ActionName 'comment' -Attributes $Attributes
		return $r
	}

	End {}
}