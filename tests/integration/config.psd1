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

    query = @{
        # Search
        "Get-SecuronixActivityEventsList" = 'accountname="admin"'
        "Get-SecuronixAssetData" = 'entityname="QUALYSTEST|30489654_42428"'
        "Get-SecuronixGeolocationData" = 'location="City:Paris Region:A8 Country:FR" and longitude="2.3488"'
        "Get-SecuronixLookupData" = 'lookupname="VulnerableHostLookUpTable"'
        "Get-SecuronixTPI" = 'tpi_type="Malicious Domain"'
        "Get-SecuronixUsersData" = 'location="Dallas" AND lastname="OGWA"'
        "Get-SecuronixViolationEventsList" = 'policyname="Email sent to self"'
        "Get-SecuronixWatchlistData" = 'watchlistname="Flight Risk Users"'
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

        # Search
        "Get-SecuronixActivityEventsList" = $true
        "Get-SecuronixAssetData" = $false
        "Get-SecuronixGeolocationData" = $false
        "Get-SecuronixLookupData" = $false
        "Get-SecuronixRiskHistory" = $true
        "Get-SecuronixRiskScorecard" = $true
        "Get-SecuronixTPI" = $false
        "Get-SecuronixUsersData" = $false
        "Get-SecuronixViolationEventsList" = $false
        "Get-SecuronixWatchlistData" = $false
    }
}