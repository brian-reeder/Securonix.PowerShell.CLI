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
function Format-ApiParameters {

    param (
        [Parameter(Mandatory)]
        [hashtable] $ParameterSet,
        [Parameter(Mandatory)]
        [string[]] $Exclusions,
        [Parameter(Mandatory)]
        [hashtable] $Aliases
    )
    
    Begin {}

    Process {
        $params = [ordered]@{}
        $ParameterSet.GetEnumerator() `
            | Where-Object { $Exclusions -notcontains $_.Key } `
            | ForEach-Object {
                $key = if($Aliases.containsKey($_.Key)) { $Aliases[$_.Key] } else { $_.Key }
                $params[$key] = $_.value
            }

        return $params
    }

    End {}
}