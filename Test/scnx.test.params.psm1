$ScnxParams = @{
    WhatIf = $true
    Url = 'DunderMifflin.securonix.com/Snypr'
    Token = '12345678-90AB-CDEF-1234-567890ABCDEF'
    Username = 'JimHalpert'
    Password = 'seEcUrEpAsSwOrD'
    WhiteListName = 'test_whitelist'
    TenantName = 'PA-Scranton'
}

Export-ModuleMember -Variable ScnxParams