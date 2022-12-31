# Securonix.PowerShell.CLI

## Description
A PowerShell module interface for working with the Securonix Web API.

This project is to provide a layer of abstraction when working with the Securonix Web API and to standardize connection requests. After experiencing some challenges working with the available documentation, this interface hopes to provide a more direct understanding of the available functionality.

## Installation
1. Download the repository.
2. Import the PowerShell module from the module manifest.
```
PS C:\..\Securonix.PowerShell.CLI> Import-Module .\Securonix.CLI.psd1
```

## Verify Installation
You can check to see if your PowerShell session has the module installed with the Get-Module cmdlet and Get-Command cmdlet.
```
PS C:\..\Securonix.PowerShell.CLI> Get-Module .\Securonix.CLI.psd1
ModuleType  Version  Name            ExportedCommands
----------  -------  ----            ----------------
Manifest    0.1       Securonix.CLI  {Confirm-SecuronixApiToken, Confirm-SecuronixIncidentActio...
```

## Links
[Securonix Web Services, SNYPR 6.4](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/_6.4%20Web%20Services_Intro.htm)
