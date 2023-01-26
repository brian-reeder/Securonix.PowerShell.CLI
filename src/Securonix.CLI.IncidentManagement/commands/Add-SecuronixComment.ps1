<#
.DESCRIPTION
Add-SecuronixComment makes an API call to the Incident/Actions endpoint and adds a comment.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER IncidentId
A required API Parameter. Enter the incident id of the incident to update.

.PARAMETER Comment
A required parameter. Enter a message to add to an incident.

.PARAMETER Username
An optional parameter. Enter the username of the user adding the comment.

.PARAMETER Firstname
An optional parameter. Enter the first name of the user adding the comment.

.PARAMETER Lastname
An optional parameter. Enter the last name of the user adding the comment.

.INPUTS
None. You cannot pipe objects to Add-SecuronixComment

.OUTPUTS
System.String. Add-SecuronixComment returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Add-SecuronixComment -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -IncidentId '10029' -Comment 'This is a test'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Add-SecuronixComment.md
#>
function Add-SecuronixComment {
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
		[string] $Comment,
		
		[string] $Username,
		[string] $Firstname,
		[string] $Lastname
	)

	Begin {		
		$Exclusions = @('WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
		}

		$Attributes = @{}
		$Attributes.Add('comment', $Comment)

		if($Username -ne '') {
			$Attributes.Add('username', $Username)
		}
		if($Firstname -ne '') {
			$Attributes.Add('firstname', $Firstname)
		}
		if($Lastname -ne '') {
			$Attributes.Add('lastname', $Lastname)
		}
	}

	Process {
		$r = Update-SecuronixIncident -Url $Url -Token $Token -IncidentId $IncidentId -ActionName 'comment' -Attributes $Attributes
		return $r
	}

	End {}
}