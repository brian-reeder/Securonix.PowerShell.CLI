﻿#
# Module manifest for module 'Securonix.CLI.Watchlist'
#
# Generated by: Brian Reeder
#
# Generated on: 1/26/2023
#

@{

# Script module or binary module file associated with this manifest.
RootModule = "$PSScriptRoot\Securonix.CLI.Watchlist.psm1"

# Version number of this module.
ModuleVersion = '0.0.1'

# ID used to uniquely identify this module
GUID = 'e36d0b62-27d3-46aa-ab27-da8157afc971'

# Author of this module
Author = '@brian-reeder'

# Copyright statement for this module
Copyright = '(c) Brian Reeder. All rights reserved.'

# Description of the functionality provided by this module
Description = 'A PowerShell module interface to interact with the Watchlist features in the Securonix SIEM web services.'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.1'

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @(
    "Add-SecuronixEntityToWatchlist",
    "Get-SecuronixEntityWatchlistList",
    "Get-SecuronixWatchlistList",
    "Get-SecuronixWatchlistMemberList",
    "New-SecuronixWatchlist"
)

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = '*'

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @("Securonix", "SIEM", "API", "Automation", "Cyber Security")

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/brian-reeder/Securonix.PowerShell.CLI'

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
HelpInfoURI = 'https://github.com/brian-reeder/Securonix.PowerShell.CLI/wiki/Securonix.CLI.Watchlist'

}

