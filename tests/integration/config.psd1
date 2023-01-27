@{
    url      = 'https://dundermifflin.securonix.net/Snypr'
    instance = 'dundermifflin'
    username = 'jhalpert'
    password = 'sEcUrEpAsSwOrD'

    incidentid   = '100107'
    status       = 'CLAIMED'
    workflowname = 'SOCTeamReview'
    tenantname   = 'PA-Scranton'
    violatorname = 'dshrute'

    timestart  = @{
        epoch = '1566249473000'
        datetime = '08/19/19 21:17:53'
    }

    timeend = @{
        epoch = '1566335873000'
        datetime = '08/20/19 21:17:53'
    }

    timeend30d = @{
        epoch = '1568945873000'
        datetime = '09/19/19 21:17:53'
    }

    disable = @{
        # Auth
        "Confirm-SecuronixApiToken" = $false
        "Connect-SecuronixApi" = $false
        "New-SecuronixApiToken" = $false
        "Update-SecuronixApiToken" = $false

        # Incident Management
        # Disabled - Issue#80
        "Add-SecuronixComment" = $true
        # Disabled - Issue#80
        "Add-SecuronixViolationScore" = $true
        "Confirm-SecuronixIncidentAction" = $false
        "Get-SecuronixChildIncidentList" = $false
        "Get-SecuronixIncident" = $false
        "Get-SecuronixIncidentActionList" = $false
        "Get-SecuronixIncidentActivityHistory" = $false
        "Get-SecuronixIncidentAPIResponse" = $false
        # Disabled - Issue#62
        "Get-SecuronixIncidentAttachments" = $true
        "Get-SecuronixIncidentsList" = $false
        "Get-SecuronixIncidentStatus" = $false
        "Get-SecuronixIncidentWorkflowName" = $false
        "Get-SecuronixThreatActionList" = $false
        "Get-SecuronixWorkflowDefaultAssignee" = $false
        "Get-SecuronixWorkflowDefinition" = $false
        "Get-SecuronixWorkflowsList" = $false
        # Disabled - Issue#80
        "New-SecuronixIncident" = $true
        # Disabled - Issue#80
        "Update-SecuronixCriticality"  = $true
        # Disabled - Issue#80
        "Update-SecuronixIncident" = $true

        # List
        "Get-SecuronixPeerGroupsList" = $false
        "Get-SecuronixPolicyList" = $false
        "Get-SecuronixResourcegroupList" = $false

        # Security Command Center (SCC)
        # Disabled - Issue#81
        "Get-SecuronixEntityThreatModel" = $true
        "Get-SecuronixThreatList" = $false
        "Get-SecuronixTopThreatsList" = $false
        "Get-SecuronixTopViolationsList" = $false
        "Get-SecuronixTopViolatorsList" = $false
    }
}