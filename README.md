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
PS C:\..\Securonix.PowerShell.CLI> Get-Module Securonix.CLI

ModuleType  Version  Name            ExportedCommands
----------  -------  ----            ----------------
Manifest    0.1       Securonix.CLI  {Confirm-SecuronixApiToken, Confirm-SecuronixIncidentActio...



PS C:\..\Securonix.PowerShell.CLI> Get-Command -Module Securonix*

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Confirm-SecuronixApiToken                          0.1        Securonix.CLI
Function        Confirm-SecuronixIncidentAction                    0.1        Securonix.CLI
Function        Get-SecuronixChildIncidents                        0.1        Securonix.CLI
Function        Get-SecuronixIncident                              0.1        Securonix.CLI
Function        Get-SecuronixIncidentActions                       0.1        Securonix.CLI
Function        Get-SecuronixIncidentActivityHistory               0.1        Securonix.CLI
Function        Get-SecuronixIncidentAPIResponse                   0.1        Securonix.CLI
Function        Get-SecuronixIncidentAttachments                   0.1        Securonix.CLI
Function        Get-SecuronixIncidentsList                         0.1        Securonix.CLI
Function        Get-SecuronixIncidentStatus                        0.1        Securonix.CLI
Function        Get-SecuronixIncidentWorkflowName                  0.1        Securonix.CLI
Function        Get-SecuronixWorkflowDefaultAssignee               0.1        Securonix.CLI
Function        Get-SecuronixWorkflowDetails                       0.1        Securonix.CLI
Function        Get-SecuronixWorkflowsList                         0.1        Securonix.CLI
Function        New-SecuronixApiToken                              0.1        Securonix.CLI
Function        Update-SecuronixApiToken                           0.1        Securonix.CLIS
```

## Links
[Securonix Web Services, SNYPR 6.4](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/_6.4%20Web%20Services_Intro.htm)
