<#
.DESCRIPTION
Get-SecuronixConnection takes a hashtable of Parameters and selects either the Securonix Connection String set in the environment or a user specified string.

.PARAMETER ParameterSet
A required parameter. A hash table of values, should be $PSBoundParameters is used within a function call.

.INPUTS
None. You cannot pipe objects to Get-SecuronixConnection

.OUTPUTS
System.String. Get-SecuronixConnection returns $url<string>,$token<string> 

.EXAMPLE
PS> Get-SecuronixConnection -ParameterSet $PSBoundParameters

#>
function Get-SecuronixConnection {

    param (
        [Parameter(Mandatory)]
        [hashtable] $ParameterSet
    )
    
    Begin {}

    Process {
        if($null -ne $ParameterSet['Url']) { 
            # Url was supplied by function call.
            $url = $ParameterSet['Url']

            if($url.EndsWith('/')) {
                $url = $url.Remove($Url.Length-1, 1)   
            }
        } else {
            if($null -eq $env:scnx_url) {
                throw 'Securonix url is not set. Call `Connect-SecuronixApi`'
            }

            # Url is provided by previous connection.
            $url = $env:scnx_url
        }

        

        $tok = if($null -ne $ParameterSet['Token']) {
            # Token was supplied by function call.
            $ParameterSet['Token'] 
        } else {
            if($null -eq $env:scnx_token) {
                throw 'Securonix token is not set. Call `Connect-SecuronixApi`'
            }
            # Token is provided by previous connection.
            $env:scnx_token
        }

        return $url,$tok
    }

    End {}
}