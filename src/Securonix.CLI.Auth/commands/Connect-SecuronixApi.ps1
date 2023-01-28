<#
.DESCRIPTION
Connect-SecuronixApi makes an API call to the AUTH/Generate Securonix Web API with the supplied credentials. If the user successfully authenticates, a token is provided.

.PARAMETER Url
Url endpoint for your Securonix instance.

.PARAMETER Instance
Subdomain for your Securonix instance.

.PARAMETER Username
Username of a Securonix account with Web API access.

.PARAMETER Password
Password of a Securonix account with Web API access.

.PARAMETER Validity
Number of days for token to remain valid.

.INPUTS
None. You cannot pipe objects to Connect-SecuronixApi

.OUTPUTS
System.String. Connect-SecuronixApi returns a Securonix API token if the credentials successfully authenticate.

.EXAMPLE
PS> Connect-SecuronixApi -Url 'https://dundermifflin.securonix.com' -Username 'JimHalpert' -Password 'sEcUrEpAsSwOrD'

.EXAMPLE
PS> Connect-SecuronixApi -Instance 'dundermifflin' -Username 'MichaelBolton' -Password 'PiEcEsOfFlAiR'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Auth/Connect-SecuronixApi.md
#>

function Connect-SecuronixApi {
    [CmdletBinding(
        DefaultParameterSetName='instance',
        PositionalBinding,
        SupportsShouldProcess
    )]
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSAvoidUsingUsernameAndPasswordParams', '',
        Scope='Function',
        Justification='Plaintext passwords are a requirement to work with the Securonix Web Api'
    )]
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSAvoidUsingPlainTextForPassword', '',
        Scope='Function',
        Justification='Plaintext passwords are a requirement to work with the Securonix Web Api'
    )]
    [OutputType([System.string])]
    param(
        [Parameter(ParameterSetName='instance',
            Mandatory,
            Position=0
        )]
        [string] $Instance,
        [Parameter(ParameterSetName='url',
            Mandatory,
            Position=0
        )]
        [string] $Url,
        [Parameter(Mandatory,
            Position=1
        )]
        [string] $Username,
        [Parameter(Mandatory,
            Position=2
        )]
        [string] $Password,
        [int] $Validity=365
    )

    Begin {
        if($Instance -ne '') {
            $Url = "https://$instance.securonix.net/Snypr"
        }
        if($Url.EndsWith('/')) {
            $Url = $Url.Remove($Url.Length-1, 1)
        }
    }

    Process {
        $tok = New-SecuronixApiToken -Url $Url `
            -Username $Username -Password $Password `
            -Validity $Validity
        if($PSCmdlet.ShouldProcess('New-SecuronixApiToken', 'SET $env:scnx_token')) {
            $env:scnx_token = $tok
        }
        if($PSCmdlet.ShouldProcess($Url, 'SET $env:scnx_url')) {
            $env:scnx_url   = $Url

            return 'Connected'
        }
    }
}