$ScnxParams = @{
    WhatIf = $true
    Url = 'DunderMifflin.securonix.com/Snypr'
    Token = '12345678-90AB-CDEF-1234-567890ABCDEF'
    Username = 'JimHalpert'
    Password = 'seEcUrEpAsSwOrD'
    WhiteListName = 'test_whitelist'
    TenantName = 'PA-Scranton'
    EmployeeId = 'jhalpert'
    ResourceName = 'dundermifflin_mst365_azuread'
    ResourceGroupId = '35'
}

Export-ModuleMember -Variable ScnxParams