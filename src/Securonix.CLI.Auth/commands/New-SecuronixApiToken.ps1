<#
.DESCRIPTION
New-SecuronixApiToken makes an API call to the AUTH/Generate Securonix Web API with the supplied credentials. If the user successfully authenticates, a token is provided.

.PARAMETER Url
Url endpoint for your Securonix instance.

.PARAMETER Username
Username of a Securonix account with Web API access.

.PARAMETER Password
Password of a Securonix account with Web API access.

.PARAMETER Validity
Number of days for token to remain valid.

.INPUTS
None. You cannot pipe objects to New-SecuronixApiToken

.OUTPUTS
System.String. New-SecuronixApiToken returns a Securonix API token if the credentials successfully authenticate.

.EXAMPLE
PS> New-SecuronixApiToken -Url "hxxps://DunderMifflin.securonix.com" -Username "JimHalpert" -Password "sEcUrEpAsSwOrD"

.EXAMPLE
PS> New-SecuronixApiToken -Url "hxxps://Initech.securonix.com" -Username "MichaelBolton" -Password "PiEcEsOfFlAiR"

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Auth/New-SecuronixApiToken.md
#>
function New-SecuronixApiToken {
    [CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSAvoidUsingPlainTextForPassword', '',
        Scope='Function',
        Justification='Plaintext passwords are a requirement to work with the Securonix Web Api'
    )]
    param(
        [Parameter(Mandatory)]
        [string] $Url,
        [Parameter(Mandatory)]
        [string] $Username,
        [Parameter(Mandatory)]
        [string] $Password,
        [int] $Validity=365
    )

    Begin {

        $Header = @{
            username = $Username
            password = $Password
            validity = $Validity
        }
        if($Url.EndsWith('/')) {
            $Url = $Url.Remove($Url.Length-1, 1)   
        }

        $Uri = "$Url/ws/token/generate"
    }

    Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -UseBasicParsing -Method Get
            return $response
        }
    }
}