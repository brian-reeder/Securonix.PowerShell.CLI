$ScnxParams = @{
    WhatIf = $true
    ActionName = 'Claim'
    EmployeeId = 'jhalpert'
    IncidentId = '100107'
    Password = 'seEcUrEpAsSwOrD'
    ResourceName = 'dundermifflin_mst365_azuread'
    ResourceGroupId = '35'
    TenantName = 'PA-Scranton'
    TimeStart_ms = '1641040200'
    TimeEnd_ms = '1641144600'
    Token = '12345678-90AB-CDEF-1234-567890ABCDEF'
    Url = 'DunderMifflin.securonix.com/Snypr'
    Username = 'JimHalpert'
    WhiteListName = 'test_whitelist'
    WorkflowName = 'SOCTeamReview'
}

Export-ModuleMember -Variable ScnxParams