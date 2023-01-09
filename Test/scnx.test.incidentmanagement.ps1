function Test-GetSecuronixIncident {
    param ()

    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Get-SecuronixIncident'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            IncidentId = $ScnxParams.IncidentId
        }
        Get-SecuronixIncident @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-GetSecuronixIncidentStatus {
    param ()

    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Get-SecuronixIncidentStatus'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            IncidentId = $ScnxParams.IncidentId
        }
        Get-SecuronixIncidentStatus @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-GetSecuronixIncidentWorkflowName {
    param ()

    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Get-SecuronixIncidentWorkflowName'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            IncidentId = $ScnxParams.IncidentId
        }
        Get-SecuronixIncidentWorkflowName @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-GetSecuronixIncidentActions {
    param ()

    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Get-SecuronixIncidentActions'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            IncidentId = $ScnxParams.IncidentId
        }
        Get-SecuronixIncidentActions @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-ConfirmSecuronixIncidentAction {
    param ()

    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Confirm-SecuronixIncidentAction'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            IncidentId = $ScnxParams.IncidentId
            ActionName = $ScnxParams.ActionName
        }
        Confirm-SecuronixIncidentAction @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-GetSecuronixWorkflowsList {
    param ()

    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Get-SecuronixWorkflowsList'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
        }
        Get-SecuronixWorkflowsList @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-GetSecuronixWorkflowDetails {
    param ()

    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Get-SecuronixWorkflowDetails'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            WorkflowName = $ScnxParams.WorkflowName
        }
        Get-SecuronixWorkflowDetails @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-GetSecuronixWorkflowDefaultAssignee {
    param ()

    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Get-SecuronixWorkflowDefaultAssignee'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            WorkflowName = $ScnxParams.WorkflowName
        }
        Get-SecuronixWorkflowDefaultAssignee @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-GetSecuronixIncidentsList {
    param ()

    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Get-SecuronixIncidentsList'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            TimeStart = $ScnxParams.TimeStart_ms
            TimeEnd = $ScnxParams.TimeEnd_ms
            RangeType = 'opened'
        }
        Get-SecuronixIncidentsList @params
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            TimeStart = $ScnxParams.TimeStart_ms
            TimeEnd = $ScnxParams.TimeEnd_ms
            RangeType = 'closed'
        }
        Get-SecuronixIncidentsList @params
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            TimeStart = $ScnxParams.TimeStart_ms
            TimeEnd = $ScnxParams.TimeEnd_ms
            RangeType = 'updated'
        }
        Get-SecuronixIncidentsList @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-GetSecuronixIncidentAttachments {
    param ()

    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Get-SecuronixIncidentAttachments'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            IncidentId = $ScnxParams.IncidentId
            TimeStart = $ScnxParams.TimeStart_ms
            TimeEnd = $ScnxParams.TimeEnd_ms
        }
        Get-SecuronixIncidentAttachments @params
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            IncidentId = $ScnxParams.IncidentId
            TimeStart = $ScnxParams.TimeStart_ms
            TimeEnd = $ScnxParams.TimeEnd_ms
            AttachmentType = 'pdf'
        }
        Get-SecuronixIncidentAttachments @params
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            IncidentId = $ScnxParams.IncidentId
            TimeStart = $ScnxParams.TimeStart_ms
            TimeEnd = $ScnxParams.TimeEnd_ms
            AttachmentType = 'csv'
        }
        Get-SecuronixIncidentAttachments @params
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            IncidentId = $ScnxParams.IncidentId
            TimeStart = $ScnxParams.TimeStart_ms
            TimeEnd = $ScnxParams.TimeEnd_ms
            AttachmentType = 'txt'
        }
        Get-SecuronixIncidentAttachments @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-GetSecuronixChildIncidents {
    param ()

    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Get-SecuronixChildIncidents'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            ParentId = $ScnxParams.IncidentId
        }
        Get-SecuronixChildIncidents @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

function Test-GetSecuronixIncidentActivityHistory {
    param ()

    begin {
        Import-Module .\scnx.test.params.psm1
    }

    process {
        Write-Host 'Testing Get-SecuronixIncidentActivityHistory'
        $params = [ordered]@{
            WhatIf = $True
            Url = $ScnxParams.Url
            Token = $ScnxParams.Token
            IncidentId = $ScnxParams.IncidentId
        }
        Get-SecuronixIncidentActivityHistory @params
        Write-Host "`r`n"
    }

    End {
        Remove-Module scnx.test.params
    }
    
}

Test-GetSecuronixIncident
Test-GetSecuronixIncidentStatus
Test-GetSecuronixIncidentWorkflowName
Test-GetSecuronixIncidentActions
Test-ConfirmSecuronixIncidentAction
Test-GetSecuronixWorkflowsList
Test-GetSecuronixWorkflowDetails
Test-GetSecuronixWorkflowDefaultAssignee
Test-GetSecuronixIncidentsList
Test-GetSecuronixIncidentAttachments
Test-GetSecuronixChildIncidents
Test-GetSecuronixIncidentActivityHistory