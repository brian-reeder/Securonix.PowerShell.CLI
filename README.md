# Securonix.PowerShell.CLI
This PowerShell module is a wrapper for the Securonix SIEM Web API, which standardizes parameters for the API endpoints. It provides an easy way to interact with the Securonix API using PowerShell commands.

## Features
- Implements functions for all of the API endpoints: Authentication, Incident Management, List, Search, Security Command Center, Watchlist, and Whitelist.
- Standardizes parameters for the API endpoints, making it easy to use the API.

## Installation
1. Download the repository.
2. Import the PowerShell module from the module manifest.
```
PS C:\..\Securonix.PowerShell.CLI> Import-Module .\src\Securonix.CLI\Securonix.CLI.psd1
```

## Verify Installation
You can check to see if your PowerShell session has the module installed with the Get-Module cmdlet and Get-Command cmdlet.
```
PS C:\..\Securonix.PowerShell.CLI> Get-Module Securonix.CLI*

ModuleType Version  PreRelease Name                              ExportedCommands
---------- -------  ---------- ----                              ----------------
Manifest   0.1                 Securonix.CLI
Script     0.0.1               Securonix.CLI.Auth                {Confirm-SecuronixApiToken, Connect-SecuronixApi, New-SecuronixApiToken, Update-SecuronixApiToken}
Script     0.0.1               Securonix.CLI.IncidentManagement  {Add-SecuronixComment, Add-SecuronixViolationScore, Confirm-SecuronixIncidentAction, Get-SecuronixChildIncidentList…}  
Script     0.0.1               Securonix.CLI.List                {Get-SecuronixPeerGroupsList, Get-SecuronixPolicyList, Get-SecuronixResourcegroupList}
Script     0.0.1               Securonix.CLI.SCC                 {Get-SecuronixEntityThreatModel, Get-SecuronixThreatList, Get-SecuronixTopThreatsList, Get-SecuronixTopViolationsList…}
Script     0.0.1               Securonix.CLI.Search              {Get-SecuronixActivityEventsList, Get-SecuronixAssetData, Get-SecuronixGeolocationData, Get-SecuronixLookupData…}      
Script     0.0.1               Securonix.CLI.Watchlist           {Add-SecuronixEntityToWatchlist, Get-SecuronixEntityWatchlistList, Get-SecuronixWatchlistList, Get-SecuronixWatchlistM…
Script     0.0.1               Securonix.CLI.Whitelist           {Add-SecuronixAttributeToWhitelist, Add-SecuronixEntityToWhitelist, Get-SecuronixWhitelist, Get-SecuronixWhitelistMemb…

```
```
PS C:\..\Securonix.PowerShell.CLI> Get-Command -Module Securonix.CLI*

CommandType  Name                                    Version  Source
-----------  ----                                    -------  ------
Function     Add-SecuronixAttributeToWhitelist       0.0.1    Securonix.CLI.Whitelist
Function     Add-SecuronixComment                    0.0.1    Securonix.CLI.IncidentManagement
Function     Add-SecuronixEntityToWatchlist          0.0.1    Securonix.CLI.Watchlist
Function     Add-SecuronixEntityToWhitelist          0.0.1    Securonix.CLI.Whitelist
Function     Add-SecuronixViolationScore             0.0.1    Securonix.CLI.IncidentManagement
Function     Confirm-SecuronixApiToken               0.0.1    Securonix.CLI.Auth
Function     Confirm-SecuronixIncidentAction         0.0.1    Securonix.CLI.IncidentManagement
Function     Connect-SecuronixApi                    0.0.1    Securonix.CLI.Auth
Function     Get-SecuronixActivityEventsList         0.0.1    Securonix.CLI.Search
Function     Get-SecuronixAssetData                  0.0.1    Securonix.CLI.Search
Function     Get-SecuronixChildIncidentList          0.0.1    Securonix.CLI.IncidentManagement
Function     Get-SecuronixEntityThreatModel          0.0.1    Securonix.CLI.SCC
Function     Get-SecuronixEntityWatchlistList        0.0.1    Securonix.CLI.Watchlist
Function     Get-SecuronixGeolocationData            0.0.1    Securonix.CLI.Search
Function     Get-SecuronixIncident                   0.0.1    Securonix.CLI.IncidentManagement
Function     Get-SecuronixIncidentActionList         0.0.1    Securonix.CLI.IncidentManagement
Function     Get-SecuronixIncidentActivityHistory    0.0.1    Securonix.CLI.IncidentManagement
Function     Get-SecuronixIncidentAPIResponse        0.0.1    Securonix.CLI.IncidentManagement
Function     Get-SecuronixIncidentsList              0.0.1    Securonix.CLI.IncidentManagement
Function     Get-SecuronixIncidentStatus             0.0.1    Securonix.CLI.IncidentManagement
Function     Get-SecuronixIncidentWorkflowName       0.0.1    Securonix.CLI.IncidentManagement
Function     Get-SecuronixLookupData                 0.0.1    Securonix.CLI.Search
Function     Get-SecuronixPeerGroupsList             0.0.1    Securonix.CLI.List
Function     Get-SecuronixPolicyList                 0.0.1    Securonix.CLI.List
Function     Get-SecuronixResourcegroupList          0.0.1    Securonix.CLI.List
Function     Get-SecuronixRiskHistory                0.0.1    Securonix.CLI.Search
Function     Get-SecuronixRiskScorecard              0.0.1    Securonix.CLI.Search
Function     Get-SecuronixThreatActionList           0.0.1    Securonix.CLI.IncidentManagement
Function     Get-SecuronixThreatList                 0.0.1    Securonix.CLI.SCC
Function     Get-SecuronixTopThreatsList             0.0.1    Securonix.CLI.SCC
Function     Get-SecuronixTopViolationsList          0.0.1    Securonix.CLI.SCC
Function     Get-SecuronixTopViolatorsList           0.0.1    Securonix.CLI.SCC
Function     Get-SecuronixTPI                        0.0.1    Securonix.CLI.Search
Function     Get-SecuronixUsersData                  0.0.1    Securonix.CLI.Search
Function     Get-SecuronixViolationEventsList        0.0.1    Securonix.CLI.Search
Function     Get-SecuronixWatchlistData              0.0.1    Securonix.CLI.Search
Function     Get-SecuronixWatchlistList              0.0.1    Securonix.CLI.Watchlist
Function     Get-SecuronixWatchlistMemberList        0.0.1    Securonix.CLI.Watchlist
Function     Get-SecuronixWhitelist                  0.0.1    Securonix.CLI.Whitelist
Function     Get-SecuronixWhitelistMemberList        0.0.1    Securonix.CLI.Whitelist
Function     Get-SecuronixWorkflowDefaultAssignee    0.0.1    Securonix.CLI.IncidentManagement
Function     Get-SecuronixWorkflowDefinition         0.0.1    Securonix.CLI.IncidentManagement
Function     Get-SecuronixWorkflowsList              0.0.1    Securonix.CLI.IncidentManagement
Function     Invoke-SecuronixSearchApi               0.0.1    Securonix.CLI.Search
Function     New-SecuronixApiToken                   0.0.1    Securonix.CLI.Auth
Function     New-SecuronixIncident                   0.0.1    Securonix.CLI.IncidentManagement
Function     New-SecuronixWatchlist                  0.0.1    Securonix.CLI.Watchlist
Function     New-SecuronixWhitelist                  0.0.1    Securonix.CLI.Whitelist
Function     Remove-SecuronixAttributeFromWhitelist  0.0.1    Securonix.CLI.Whitelist
Function     Remove-SecuronixEntityFromWhitelist     0.0.1    Securonix.CLI.Whitelist
Function     Update-SecuronixApiToken                0.0.1    Securonix.CLI.Auth
Function     Update-SecuronixCriticality             0.0.1    Securonix.CLI.IncidentManagement
Function     Update-SecuronixIncident                0.0.1    Securonix.CLI.IncidentManagement
```

## Support
If you have any questions or issues with this module, please open an issue on the GitHub repository or contact the module maintainer.

## Links
[Securonix Web Services, SNYPR 6.4](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/_6.4%20Web%20Services_Intro.htm)
