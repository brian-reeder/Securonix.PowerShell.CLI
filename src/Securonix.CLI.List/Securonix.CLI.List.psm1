$commands = (Get-ChildItem -Recurse -Path "$PSScriptRoot\commands").PSPath
$utils    = (Get-ChildItem -Recurse -Path "$PSScriptRoot\..\utils").PSPath

foreach($file in @($utils + $commands)) {
    . $file
}

Export-ModuleMember -Function '*'