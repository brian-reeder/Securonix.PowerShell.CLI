<#
.DESCRIPTION
Get-SecuronixIncidentAttachments makes an API call to the Incident/Get endpoint and retrieves attachments from an incident.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter, enter the incident id to view the attachments.

.PARAMETER TimeStart
A required API Parameter, enter starting point for the search. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS-00'.

.PARAMETER TimeEnd
A required API Parameter, enter ending point for the search. Time (epoch) in ms or Date Time in 'mm/dd/YYYY HH:MM:SS-00'.

.PARAMETER AttachmentType
A required API Parameter, select any of: csv, pdf, txt.

.INPUTS
None. You cannot pipe objects to Get-SecuronixIncidentAttachments

.OUTPUTS
System.String. Get-SecuronixIncidentAttachments returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixIncidentAttachments -Url "hxxps://DunderMifflin.securonix.com/Snypr" -Token "12345678-90AB-CDEF-1234-567890ABCDEF" -IncidentId 1234567890

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixIncidentAttachments.md
#>
function Get-SecuronixIncidentAttachments {

	[CmdletBinding(
		DefaultParameterSetName='default',
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token,
		[Parameter(Mandatory)]
		[string] $IncidentId,
		[Parameter(ParameterSetName='filtertime',Mandatory)]
		[string] $TimeStart,
		[Parameter(ParameterSetName='filtertime',Mandatory)]
		[string] $TimeEnd,
		[ValidateSet('pdf','csv','txt')]
		[string] $AttachmentType


	)

	Begin {
		$PSBoundParameters['TimeStart'] = Convert-StringTime -InputDateTime $TimeStart -OutEpoch
        $PSBoundParameters['TimeEnd']   = Convert-StringTime -InputDateTime $TimeEnd -OutEpoch

		$paramsTable = @{
			'IncidentId' = 'incidentId'
			'AttachmentType' = 'attachmenttype'
			'TimeStart' = 'datefrom'
			'TimeEnd' = 'dateto'
		}

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
			$paramsList += "$($paramsTable[$param])=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/attachments?$($paramsList -join '&')"
	}

	Process {
		if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
			$response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
			return $response.result
		}
	}

	End {}
}