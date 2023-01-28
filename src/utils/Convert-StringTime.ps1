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
        [Parameter(Mandatory)]
        [string] $InputDateTime,
        [Parameter(Mandatory, ParameterSetName='datetime')]
        [switch] $OutDateTime,
        [Parameter(Mandatory, ParameterSetName='epoch')]
        [switch] $OutEpoch
    )

    Begin {
        if($InputDateTime -match "^[\d]+$") {
            [System.DateTime]$newDateTime = (Get-Date -Date '01-01-1970') `
                + ([System.TimeSpan]::FromMilliseconds(($InputDateTime)))
        }
        else {
            [System.DateTime]$newDateTime = Get-Date -Date $InputDateTime
        }
    }

    Process {
        if($OutDateTime) {
            return Get-Date $newDateTime -UFormat "%m/%d/%Y %T"
        }

        if($OutEpoch) {
            return ([System.DateTimeOffset]$newDateTime).ToUnixTimeMilliseconds()
        }

        return ''
    }

    End {}
}