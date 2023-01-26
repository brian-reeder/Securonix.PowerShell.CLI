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