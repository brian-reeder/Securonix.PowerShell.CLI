<#
.DESCRIPTION
Get-SecuronixWorkflowsList makes an API call to the Incident/Get endpoint and retrieves the list of available Workflows for Incidents.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Get-SecuronixWorkflowsList

.OUTPUTS
System.String. Get-SecuronixWorkflowsList returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixWorkflowsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Incident%20Management/Get-SecuronixWorkflowsList.md
#>
function Get-SecuronixWorkflowsList {
	[CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
	[System.Diagnostics.CodeAnalysis.SuppressMessage('PSShouldProcess', '',
        Scope='Function',
        Justification='ShouldProcess is handled by the function Get-SecuronixIncidentAPIResponse'
    )]
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token
	)

	Begin {}

	Process {
		$r = Get-SecuronixIncidentAPIResponse -Url $Url -Token $Token -type 'workflows'
		return $r.workflows
	}

	End {}
}