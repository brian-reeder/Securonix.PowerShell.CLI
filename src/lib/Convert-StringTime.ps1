<#
.DESCRIPTION
Convert-StringTime takes either a string in DateTime or Epoch time format and converts it to the other type.

.PARAMETER DateTime
A required parameter. A string representing a time in the format 'dd/MM/YYYY HH:mm:ss'.

.PARAMETER Epoch
A required parameter. A string representing a time in ms.

.INPUTS
None. You cannot pipe objects to Convert-StringTime

.OUTPUTS
System.String. Convert-StringTime returns a string in DateTime format if Epoch was supplied, and returns a string in Epoch format if DateTime was supplied.

.EXAMPLE
PS> Convert-StringTime -DateTime '02/28/2007 14:45:59'

.EXAMPLE
PS> Convert-StringTime -DateTime '02/28/2007 14:45:59'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Auth/Convert-StringTime.md
#>
function Convert-StringTime {

    param (
        [Parameter(Mandatory, ParameterSetName='datetime')]
        [string] $DateTime,
        [Parameter(Mandatory, ParameterSetName='epoch')]
        [string] $Epoch
    )
    
    Begin {}

    Process {
        if($DateTime -ne '') {
            [System.DateTime]$newDateTime = Get-Date -Date $DateTime
            return ([System.DateTimeOffset]$newDateTime).ToUnixTimeMilliseconds()
        }

        if($Epoch -ne '') {
            $obj = (Get-Date -Date '01-01-1970') + ([System.TimeSpan]::FromMilliseconds(($Epoch)))

            return Get-Date $obj -UFormat "%D %T"
        }
    }

    End {}
}