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

ModuleType  Version  PreRelease  Name           ExportedCommands
----------  -------  ----------  ----           ----------------
Manifest    0.1                Securonix.CLI  {Add-SecuronixAttributeToWhitelist, Add-SecuronixEntityToWatchlist, Add-SecuronixEntityToWhitelist, Confirm-SecuronixApiToken…
```
```
PS C:\..\Securonix.PowerShell.CLI> Get-Command -Module Securonix.CLI

CommandType  Name                                    Version  Source
-----------  ----                                    -------  ------
Function     Add-SecuronixAttributeToWhitelist       0.1      Securonix.CLI
Function     Add-SecuronixEntityToWatchlist          0.1      Securonix.CLI
Function     Add-SecuronixEntityToWhitelist          0.1      Securonix.CLI
Function     Confirm-SecuronixApiToken               0.1      Securonix.CLI
Function     Confirm-SecuronixIncidentAction         0.1      Securonix.CLI
Function     Get-SecuronixActivityEvents             0.1      Securonix.CLI
Function     Get-SecuronixAssetData                  0.1      Securonix.CLI
Function     Get-SecuronixChildIncidents             0.1      Securonix.CLI
Function     Get-SecuronixEntityThreatDetails        0.1      Securonix.CLI
Function     Get-SecuronixEntityWatchlists           0.1      Securonix.CLI
Function     Get-SecuronixGeolocationData            0.1      Securonix.CLI
Function     Get-SecuronixIncident                   0.1      Securonix.CLI
Function     Get-SecuronixIncidentActions            0.1      Securonix.CLI
Function     Get-SecuronixIncidentActivityHistory    0.1      Securonix.CLI
Function     Get-SecuronixIncidentAPIResponse        0.1      Securonix.CLI
Function     Get-SecuronixIncidentAttachments        0.1      Securonix.CLI
Function     Get-SecuronixIncidentsList              0.1      Securonix.CLI
Function     Get-SecuronixIncidentStatus             0.1      Securonix.CLI
Function     Get-SecuronixIncidentWorkflowName       0.1      Securonix.CLI
Function     Get-SecuronixLookupData                 0.1      Securonix.CLI
Function     Get-SecuronixPeerGroupsList             0.1      Securonix.CLI
Function     Get-SecuronixPolicyList                 0.1      Securonix.CLI
Function     Get-SecuronixResourcegroupList          0.1      Securonix.CLI
Function     Get-SecuronixRiskHistory                0.1      Securonix.CLI
Function     Get-SecuronixRiskScorecard              0.1      Securonix.CLI
Function     Get-SecuronixSearchAPIResponse          0.1      Securonix.CLI
Function     Get-SecuronixThreats                    0.1      Securonix.CLI
Function     Get-SecuronixTopThreats                 0.1      Securonix.CLI
Function     Get-SecuronixTopViolations              0.1      Securonix.CLI
Function     Get-SecuronixTopViolators               0.1      Securonix.CLI
Function     Get-SecuronixTPI                        0.1      Securonix.CLI
Function     Get-SecuronixUsersData                  0.1      Securonix.CLI
Function     Get-SecuronixViolationEvents            0.1      Securonix.CLI
Function     Get-SecuronixWatchlistData              0.1      Securonix.CLI
Function     Get-SecuronixWatchlistList              0.1      Securonix.CLI
Function     Get-SecuronixWatchlistMembers           0.1      Securonix.CLI
Function     Get-SecuronixWhitelist                  0.1      Securonix.CLI
Function     Get-SecuronixWhitelistMembers           0.1      Securonix.CLI
Function     Get-SecuronixWorkflowDefaultAssignee    0.1      Securonix.CLI
Function     Get-SecuronixWorkflowDetails            0.1      Securonix.CLI
Function     Get-SecuronixWorkflowsList              0.1      Securonix.CLI
Function     New-SecuronixApiToken                   0.1      Securonix.CLI
Function     New-SecuronixWatchlist                  0.1      Securonix.CLI
Function     New-SecuronixWhitelist                  0.1      Securonix.CLI
Function     Remove-SecuronixAttributeFromWhitelist  0.1      Securonix.CLI
Function     Remove-SecuronixEntityFromWhitelist     0.1      Securonix.CLI
Function     Update-SecuronixApiToken                0.1      Securonix.CLI
```

## Links
[Securonix Web Services, SNYPR 6.4](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/_6.4%20Web%20Services_Intro.htm)
