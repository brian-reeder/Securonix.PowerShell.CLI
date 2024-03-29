# Securonix.PowerShell.CLI
![example workflow](https://github.com/brian-reeder/Securonix.PowerShell.CLI/actions/workflows/Pull%20Checks.yml/badge.svg)

This PowerShell module is a wrapper for the Securonix SIEM Web API, which standardizes parameters for the API endpoints. It provides an easy way to interact with the Securonix API using PowerShell commands.

## Features
- Implements functions for all of the API endpoints: Authentication, Incident Management, List, Search, Security Command Center, Watchlist, and Whitelist.
- Standardizes parameters for the API endpoints, making it easy to use the API.

## Installation
1. Download the repository.

2. Add the src directory to your module path
    ```
    PS C:\..\Securonix.PowerShell.CLI> $srcpath = (Get-ChildItem . -Directory -Filter 'src').FullName
    PS C:\..\Securonix.PowerShell.CLI> $env:PSModulePath = @($env:PSModulePath, $srcpath) -join ';'
    ```

3. Import the PowerShell module from the module manifest.
    ```
    PS C:\..\Securonix.PowerShell.CLI> Import-Module Securonix.CLI
    ```

## Verify Installation
You can check to see if your PowerShell session has the module installed with the Get-Module cmdlet and Get-Command cmdlet.
```
PS C:\..\Securonix.PowerShell.CLI> Get-Module Securonix.CLI*

ModuleType Version  PreRelease Name                              ExportedCommands
---------- -------  ---------- ----                              ----------------
Manifest   0.0.1               Securonix.CLI
Script     1.0.0               Securonix.CLI.Auth                {Confirm-SecuronixApiToken, Connect-SecuronixApi, New-SecuronixApiToken, Update-SecuronixApiToken}
Script     1.0.0               Securonix.CLI.IncidentManagement  {Add-SecuronixComment, Add-SecuronixViolationScore, Confirm-SecuronixIncidentAction, Get-SecuronixChildIncidentList…}  
Script     1.0.0               Securonix.CLI.List                {Get-SecuronixPeerGroupsList, Get-SecuronixPolicyList, Get-SecuronixResourcegroupList}
Script     1.0.0               Securonix.CLI.SCC                 {Get-SecuronixEntityThreatModel, Get-SecuronixThreatList, Get-SecuronixTopThreatsList, Get-SecuronixTopViolationsList…}
Script     1.0.0               Securonix.CLI.Search              {Get-SecuronixActivityEventsList, Get-SecuronixAssetData, Get-SecuronixGeolocationData, Get-SecuronixLookupData…}      
Script     1.0.0               Securonix.CLI.Watchlist           {Add-SecuronixEntityToWatchlist, Get-SecuronixEntityWatchlistList, Get-SecuronixWatchlistList, Get-SecuronixWatchlistM…
Script     1.0.0               Securonix.CLI.Whitelist           {Add-SecuronixAttributeToWhitelist, Add-SecuronixEntityToWhitelist, Get-SecuronixWhitelist, Get-SecuronixWhitelistMemb…

```
```
PS C:\..\Securonix.PowerShell.CLI> Get-Command -Module Securonix.CLI*

CommandType  Name                                    Version  Source
-----------  ----                                    -------  ------
Function     Add-SecuronixAttributeToWhitelist       1.0.0    Securonix.CLI.Whitelist
Function     Add-SecuronixComment                    1.0.0    Securonix.CLI.IncidentManagement
Function     Add-SecuronixEntityToWatchlist          1.0.0    Securonix.CLI.Watchlist
Function     Add-SecuronixEntityToWhitelist          1.0.0    Securonix.CLI.Whitelist
Function     Add-SecuronixViolationScore             1.0.0    Securonix.CLI.IncidentManagement
Function     Confirm-SecuronixApiToken               1.0.0    Securonix.CLI.Auth
Function     Confirm-SecuronixIncidentAction         1.0.0    Securonix.CLI.IncidentManagement
Function     Connect-SecuronixApi                    1.0.0    Securonix.CLI.Auth
Function     Get-SecuronixActivityEventsList         1.0.0    Securonix.CLI.Search
Function     Get-SecuronixAssetData                  1.0.0    Securonix.CLI.Search
Function     Get-SecuronixChildIncidentList          1.0.0    Securonix.CLI.IncidentManagement
Function     Get-SecuronixEntityThreatModel          1.0.0    Securonix.CLI.SCC
Function     Get-SecuronixEntityWatchlistList        1.0.0    Securonix.CLI.Watchlist
Function     Get-SecuronixGeolocationData            1.0.0    Securonix.CLI.Search
Function     Get-SecuronixIncident                   1.0.0    Securonix.CLI.IncidentManagement
Function     Get-SecuronixIncidentActionList         1.0.0    Securonix.CLI.IncidentManagement
Function     Get-SecuronixIncidentActivityHistory    1.0.0    Securonix.CLI.IncidentManagement
Function     Get-SecuronixIncidentAPIResponse        1.0.0    Securonix.CLI.IncidentManagement
Function     Get-SecuronixIncidentsList              1.0.0    Securonix.CLI.IncidentManagement
Function     Get-SecuronixIncidentStatus             1.0.0    Securonix.CLI.IncidentManagement
Function     Get-SecuronixIncidentWorkflowName       1.0.0    Securonix.CLI.IncidentManagement
Function     Get-SecuronixLookupData                 1.0.0    Securonix.CLI.Search
Function     Get-SecuronixPeerGroupsList             1.0.0    Securonix.CLI.List
Function     Get-SecuronixPolicyList                 1.0.0    Securonix.CLI.List
Function     Get-SecuronixResourcegroupList          1.0.0    Securonix.CLI.List
Function     Get-SecuronixRiskHistory                1.0.0    Securonix.CLI.Search
Function     Get-SecuronixRiskScorecard              1.0.0    Securonix.CLI.Search
Function     Get-SecuronixThreatActionList           1.0.0    Securonix.CLI.IncidentManagement
Function     Get-SecuronixThreatList                 1.0.0    Securonix.CLI.SCC
Function     Get-SecuronixTopThreatsList             1.0.0    Securonix.CLI.SCC
Function     Get-SecuronixTopViolationsList          1.0.0    Securonix.CLI.SCC
Function     Get-SecuronixTopViolatorsList           1.0.0    Securonix.CLI.SCC
Function     Get-SecuronixTPI                        1.0.0    Securonix.CLI.Search
Function     Get-SecuronixUsersData                  1.0.0    Securonix.CLI.Search
Function     Get-SecuronixViolationEventsList        1.0.0    Securonix.CLI.Search
Function     Get-SecuronixWatchlistData              1.0.0    Securonix.CLI.Search
Function     Get-SecuronixWatchlistList              1.0.0    Securonix.CLI.Watchlist
Function     Get-SecuronixWatchlistMemberList        1.0.0    Securonix.CLI.Watchlist
Function     Get-SecuronixWhitelist                  1.0.0    Securonix.CLI.Whitelist
Function     Get-SecuronixWhitelistMemberList        1.0.0    Securonix.CLI.Whitelist
Function     Get-SecuronixWorkflowDefaultAssignee    1.0.0    Securonix.CLI.IncidentManagement
Function     Get-SecuronixWorkflowDefinition         1.0.0    Securonix.CLI.IncidentManagement
Function     Get-SecuronixWorkflowsList              1.0.0    Securonix.CLI.IncidentManagement
Function     Invoke-SecuronixSearchApi               1.0.0    Securonix.CLI.Search
Function     New-SecuronixApiToken                   1.0.0    Securonix.CLI.Auth
Function     New-SecuronixIncident                   1.0.0    Securonix.CLI.IncidentManagement
Function     New-SecuronixWatchlist                  1.0.0    Securonix.CLI.Watchlist
Function     New-SecuronixWhitelist                  1.0.0    Securonix.CLI.Whitelist
Function     Remove-SecuronixAttributeFromWhitelist  1.0.0    Securonix.CLI.Whitelist
Function     Remove-SecuronixEntityFromWhitelist     1.0.0    Securonix.CLI.Whitelist
Function     Update-SecuronixApiToken                1.0.0    Securonix.CLI.Auth
Function     Update-SecuronixCriticality             1.0.0    Securonix.CLI.IncidentManagement
Function     Update-SecuronixIncident                1.0.0    Securonix.CLI.IncidentManagement
```

## Support
If you have any questions or issues with this module, please open an issue on the GitHub repository or contact the module maintainer.

## Links
[Securonix Web Services, SNYPR 6.4](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/_6.4%20Web%20Services_Intro.htm)
