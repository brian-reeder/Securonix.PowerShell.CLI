
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
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSAvoidUsingPlainTextForPassword', '',
        Scope='Function',
        Justification='Plaintext passwords are a requirement to work with the Securonix Web Api'
    )]
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

<#
.DESCRIPTION
Confirm-SecuronixApiToken makes an API call to the AUTH/Validate Securonix Web API with the supplied token. If the token is valid, the API will respond with "Valid".

.PARAMETER Url
Url endpoint for your Securonix instance.

.PARAMETER Token
An API token to test. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Confirm-SecuronixApiToken

.OUTPUTS
System.String. Confirm-SecuronixApiToken returns the API response. The API will respond with "Valid" for valid API tokens.

.EXAMPLE
PS> Confirm-SecuronixApiToken -Url "hxxps://DunderMifflin.securonix.com" -Token "12345678-90AB-CDEF-1234-567890ABCDEF"

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Auth/Confirm-SecuronixApiToken.md
#>
function Confirm-SecuronixApiToken {
    [CmdletBinding(
        DefaultParameterSetName='default',
        PositionalBinding,
        SupportsShouldProcess
    )]
    param(
        [Parameter(ParameterSetName='supplied',
            Mandatory,
            Position=0
        )]
        [string] $Url,
        [Parameter(ParameterSetName='supplied',
            Mandatory,
            Position=1
        )]
        [string] $Token
    )

    Begin {
        . "$PSScriptRoot/lib/Get-SecuronixConnection.ps1"

        $Url,$Token = Get-SecuronixConnection -ParameterSet $PSBoundParameters

        $Header = @{
            token = $Token
        }

        $Uri = "$Url/ws/token/validate"
    }

    Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -UseBasicParsing -Method Get
            return $response
        }
    }

    End {}
}

<#
.DESCRIPTION
Update-SecuronixApiToken makes an API call to the AUTH/Renew Securonix Web API to renew the supplied token. If the token was renewed, the API will respond with "Success".

.PARAMETER Url
Url endpoint for your Securonix instance.

.PARAMETER Token
An API token to renew. Use New-SecuronixApiToken to generate a new token.

.INPUTS
None. You cannot pipe objects to Update-SecuronixApiToken

.OUTPUTS
System.String. Update-SecuronixApiToken returns the API response. The API will respond with "Success" for renewed API tokens.

.EXAMPLE
PS> Update-SecuronixApiToken -Url "hxxps://DunderMifflin.securonix.com" -Token "12345678-90AB-CDEF-1234-567890ABCDEF"

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Auth/Update-SecuronixApiToken.md
#>
function Update-SecuronixApiToken {
    [CmdletBinding(
        DefaultParameterSetName='default',
        PositionalBinding,
        SupportsShouldProcess
    )]
    param(
        [Parameter(ParameterSetName='supplied',
            Mandatory,
            Position=0
        )]
        [string] $Url,
        [Parameter(ParameterSetName='supplied',
            Mandatory,
            Position=1
        )]
        [string] $Token
    )

    Begin {
        . "$PSScriptRoot/lib/Get-SecuronixConnection.ps1"

        $Url,$Token = Get-SecuronixConnection -ParameterSet $PSBoundParameters

        $Header = @{
            token = $Token
        }

        $Uri = "$Url/ws/token/renew"
    }

    Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -UseBasicParsing -Method Get
            return $response
        }
        
    }

    End {}
}

Export-ModuleMember -Function New-SecuronixApiToken
Export-ModuleMember -Function Connect-SecuronixApi
Export-ModuleMember -Function Confirm-SecuronixApiToken
Export-ModuleMember -Function Update-SecuronixApiToken