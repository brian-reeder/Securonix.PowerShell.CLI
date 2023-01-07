<#
.DESCRIPTION
New-SecuronixWhitelist prepares API parameters and requests Securonix to create a new whitelist.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WhitelistName
A required API Parameter, the name of the whitelist you want to create.

.PARAMETER TenantName
A required API Parameter, the name of the tenant this whitelist should belong to.

.PARAMETER EntityType
A required API Parameter, enter the type of entity this whitelist is intended to hold. May be the following types: 'Users', 'Activityaccount', 'Resources', 'IpAddress'.

.INPUTS
None. You cannot pipe objects to New-SecuronixWhitelist

.OUTPUTS
System.String. New-SecuronixWhitelist returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> New-SecuronixWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'test_whitelist' -TenantName 'PA-Scranton' -EntityType 'Users'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Whitelist/New-SecuronixWhitelist.md
#>
function New-SecuronixWhitelist {
    [CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token,
        [Parameter(Mandatory)]
		[string] $WhitelistName,
        [Parameter(Mandatory)]
		[string] $TenantName,
        [Parameter(Mandatory)]
        [ValidateSet('Users', 'Activityaccount', 'Resources', 'IpAddress')]
		[string] $EntityType
	)

	Begin {
        if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

        $Exclusions = @('Url', 'Token', 'WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        $paramsTable = @{
            'WatchlistName' = 'watchlistname'
            'TenantName' = 'tenantname'
            'EntityType' = 'entitytype'
		}

		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/createGlobalWhitelist?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}

<#
.DESCRIPTION
Remove-SecuronixAttributeFromWhitelist prepares API parameters and requests Securonix to remove an entity from a whitelist.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WhitelistName
A required API Parameter, the name of the whitelist you want to remove an entity from.

.PARAMETER TenantName
A required API Parameter, the name of the tenant the whitelist belongs to.

.PARAMETER EntityId
A required API Parameter, the id to remove from a whitelist. Employeeid for type User, accountname for type Activityaccount, resourcename for type Resources, and ipaddress for type IpAddress

.PARAMETER EntityIdList
A required API Parameter, a list of Entity Ids to remove from a whitelist. Max number of 5 at a time.

.INPUTS
None. You cannot pipe objects to Remove-SecuronixEntityFromWhitelist

.OUTPUTS
System.String. Remove-SecuronixEntityFromWhitelist returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Remove-SecuronixEntityFromWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'remote_users' -TenantName 'PA-Scranton' -EntityId 'jhalpert'

.EXAMPLE
PS> Remove-SecuronixEntityFromWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'datacenter_ips' -TenantName 'NY-New_York_City' -EntityIdList @('192.168.0.1','172.16.0.1','10.0.0.1','127.0.0.1')

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Whitelist/Remove-SecuronixEntityFromWhitelist.md
#>
function Remove-SecuronixEntityFromWhitelist {
    [CmdletBinding(
        DefaultParameterSetName='single',
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(
            Mandatory,
            Position=0
        )]
		[string] $Url,
		[Parameter(
            Mandatory,
            Position=1
        )]
		[string] $Token,
        [Parameter(
            Mandatory,
            Position=2
        )]
		[string] $WhitelistName,
        [Parameter(
            Mandatory,
            Position=3
        )]
		[string] $TenantName,
        [Parameter(
            ParameterSetName='single',
            Mandatory,
            Position=4
        )]
		[string] $EntityId,
        [Parameter(
            ParameterSetName='list',
            Mandatory,
            Position=4
        )]
		[string[]] $EntityIdList
	)

	Begin {
        if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

        if($EntityIdList.Count -gt 5) {
            throw "Too many Entity Ids provided. Max 5 supported by API, you entered `"$($EntityIdList.count)`"."
        }
        elseif ($EntityIdList.Count -gt 0) {
            $EntityId = $EntityIdList -join ','
            $PSBoundParameters.Add('EntityId', $EntityId)
            $PSBoundParameters.Remove('EntityIdList') | Out-Null
        }

		$Header = [ordered]@{
			'token' = $Token
		}

        $Exclusions = @('Url', 'Token', 'WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        $paramsTable = @{
            'WhitelistName' = 'whitelistname'
            'TenantName' = 'tenantname'
            'EntityId' = 'entityid'
		}

		$paramsList = @('whitelisttype=global')
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/removeFromWhitelist?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}

<#
.DESCRIPTION
Remove-SecuronixAttributeFromWhitelist prepares API parameters and requests Securonix to remove an attribute from a whitelist.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WhitelistName
A required API Parameter, the name of the whitelist to remove an attribute from.

.PARAMETER TenantName
A required API Parameter, the name of the tenant the whitelist belongs to.

.PARAMETER AttributeName
A required API Parameter, the name of an attribute being removed. Possible values include: accountname, transactionstring, sourcetype.

.PARAMETER AttributeValue
A required API Parameter, the value of the attribute to remove from a whitelist.

.PARAMETER AttributeValueList
A required API Parameter, a list of Attribute Values to remove from a white list. Max number of 5 at a time.

.INPUTS
None. You cannot pipe objects to Remove-SecuronixAttributeFromWhitelist

.OUTPUTS
System.String. Remove-SecuronixAttributeFromWhitelist returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Remove-SecuronixAttributeFromWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'remote_users' -TenantName 'PA-Scranton' -AttributeName 'accountname' -AttributeValue 'jhalpert'

.EXAMPLE
PS> Remove-SecuronixAttributeFromWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'remote_users' -TenantName 'PA-Scranton' -AttributeName 'accountname' -AttributeValueList @('jhalpert','dshrute','mscott')

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Whitelist/Remove-SecuronixEntityFromWhitelist.md
#>
function Remove-SecuronixAttributeFromWhitelist {
    [CmdletBinding(
        DefaultParameterSetName='single',
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(
            Mandatory,
            Position=0
        )]
		[string] $Url,
		[Parameter(
            Mandatory,
            Position=1
        )]
		[string] $Token,
        [Parameter(
            Mandatory,
            Position=2
        )]
		[string] $WhitelistName,
        [Parameter(
            Mandatory,
            Position=3
        )]
		[string] $TenantName,
        [Parameter(
            Mandatory,
            Position=4
        )]
		[string] $AttributeName,
        [Parameter(
            ParameterSetName='single',
            Mandatory,
            Position=5
        )]
		[string] $AttributeValue,
        [Parameter(
            ParameterSetName='list',
            Mandatory,
            Position=5
        )]
		[string[]] $AttributeValueList
	)

	Begin {
        if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

        if($AttributeValueList.Count -gt 5) {
            throw "Too many Attribute Ids provided. Max 5 supported by API, you entered `"$($AttributeValueList.count)`"."
        }
        elseif ($AttributeValueList.Count -gt 0) {
            $AttributeValue = $AttributeValueList -join ','
            $PSBoundParameters.Add('AttributeValue', $AttributeValue)
            $PSBoundParameters.Remove('AttributeValueList') | Out-Null
        }

		$Header = [ordered]@{
			'token' = $Token
		}

        $Exclusions = @('Url', 'Token', 'WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        $paramsTable = @{
            'WhitelistName' = 'whitelistname'
            'TenantName' = 'tenantname'
            'AttributeName' = 'attributename'
            'AttributeValue' = 'attributevalue'
		}

		$paramsList = @('whitelisttype=attribute')
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/removeFromWhitelist?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}

<#
.DESCRIPTION
Add-SecuronixEntityToWhitelist prepares API parameters and requests Securonix to add an entity to a whitelist.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WhitelistName
A required API Parameter, the name of the whitelist you want to add an entity to.

.PARAMETER TenantName
A required API Parameter, the name of the tenant the whitelist belongs to.

.PARAMETER EntityType
A required API Parameter, enter the type of entity being added. It is recommended to use the following parameters instead: -UsersEntityType, -ActivityaccountEntityType, -ActivityipEntityType, -ResourcesEntityType. May be the following types: 'Users', 'Activityaccount', 'Activityip', 'Resources'.

.PARAMETER EntityId
The entity id to to add a whitelist. Required for use with the EntityType parameter.

.PARAMETER UsersEntityId
A required API Parameter, automatically specifies the EntityType as Users. Enter the entity id of the user being added. 

.PARAMETER ActivityaccountEntityType
A required API Parameter, automatically specifies the EntityType as Activityaccount. Enter the entity id of the activityaccount being added.

.PARAMETER ActivityipEntityType
A required API Parameter, automatically specifies the EntityType as Activityip. Enter the entity id of the activityip being added.

.PARAMETER ResourcesEntityType
A required API Parameter, automatically specifies the EntityType as Resources. Enter the entity id of the resource being added.

.PARAMETER ResourceName
This parameter is required if the EntityType is Activityaccount. Enter the resource name that an account belongs to.

.PARAMETER ResourceGroupId
This parameter is required if the EntityType is Activityaccount. Enter the resourcegroupid assigned to the Resource the account belongs to.

.PARAMETER ExpiryDate
An optional API Parameter, enter the date Securonix will remove the entity from the whitelist. Format: MM/DD/YYYY
.INPUTS
None. You cannot pipe objects to Add-SecuronixEntityToWhitelist.

.OUTPUTS
System.String. Add-SecuronixEntityToWhitelist returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Add-SecuronixEntityToWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'remote_users' -TenantName 'PA-Scranton' -ActivityaccountId 'jhalpert' -ResourceName 'dundermifflin_msft365_azuread' -ResourceGroupId '35' -ExpiryDate '05/16/2013'

.EXAMPLE
PS> Add-SecuronixEntityToWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'infosec_servers' -TenantName 'NY-New_York_City' -ActivityipEntityId '192.168.1.55'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Whitelist/Add-SecuronixEntityToWhitelist.md
#>
function Add-SecuronixEntityToWhitelist {
    [CmdletBinding(
        DefaultParameterSetName='entitytype',
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory,Position=0)]
		[string] $Url,
		[Parameter(Mandatory,Position=1)]
		[string] $Token,
        [Parameter(Mandatory,Position=2)]
		[string] $WhitelistName,
        [Parameter(Mandatory,Position=3)]
		[string] $TenantName,
        [Parameter(ParameterSetName='entitytype',
            Mandatory,
            Position=4
        )]
        [ValidateSet('Users', 'Activityaccount', 'Activityip', 'Resources')]
		[string] $EntityType,
        [Parameter(ParameterSetName='entitytype',
            Mandatory,
            Position=5
        )]
        [string] $EntityId,
        [Parameter(ParameterSetName='Users',Mandatory)]
		[string] $UsersEntityId,
        [Parameter(ParameterSetName='Activityaccount',Mandatory)]
		[string] $ActivityaccountEntityId,
        [Parameter(ParameterSetName='Activityip',Mandatory)]
		[string] $ActivityipEntityId,
        [Parameter(ParameterSetName='Resources',Mandatory)]
		[string] $ResourcesEntityId,
        [Parameter(ParameterSetName='entitytype',Mandatory)]
        [Parameter(ParameterSetName='Activityaccount',Mandatory)]
        [Parameter()]
        [string] $ResourceName,
        [Parameter(ParameterSetName='entitytype',Mandatory)]
        [Parameter(ParameterSetName='Activityaccount',Mandatory)]
        [Parameter()]
        [string] $ResourceGroupId,
        [string] $ExpiryDate
	)

	Begin {
        if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

        if($EntityType -eq '') {
            if($UsersEntityId -ne ''){
                $EntityType = 'Users'
                $EntityId = $UsersEntityId
                $PSBoundParameters.Remove('UsersEntityId') | Out-Null
            } 
            elseif ($ActivityaccountEntityId -ne '') {
                $EntityType = 'Activityaccount'
                $EntityId = $ActivityaccountEntityId
                $PSBoundParameters.Remove('ActivityaccountEntityId') | Out-Null
            } 
            elseif ($ActivityipEntityId -ne '') {
                $EntityType = 'Activityip'
                $EntityId = $ActivityipEntityId
                $PSBoundParameters.Remove('ActivityipEntityId') | Out-Null
            } 
            elseif($ResourcesEntityId -ne '') {
                $EntityType = 'Resources'
                $EntityId = $ResourcesEntityId
                $PSBoundParameters.Remove('ResourcesEntityId') | Out-Null
            }

            $PSBoundParameters.Add('EntityType',$EntityType)
            $PSBoundParameters.Add('EntityId',$EntityId)
        }

        if($EntityType -eq 'Activityaccount') {
            if($ResourceName -eq '') {
                throw "ResourceName equals empty string. ResourceName is required for EntityType='ActivityAccount'."
            }
            if($ResourceGroupId -eq '') {
                throw "ResourceGroupId equals empty string. ResourceGroupId is required for EntityType='ActivityAccount'."
            }
        }

        $Exclusions = @('Url', 'Token', 'WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        $paramsTable = @{
            'WhitelistName' = 'whitelistname'
            'TenantName' = 'tenantname'
            'EntityType' ='entitytype'
            'EntityId' = 'entityid'
            'ExpiryDate' = 'expirydate'
            'ResourceName' = 'resourcename'
            'ResourceGroupId' = 'resourcegroupid'
		}

		$paramsList = @('whitelisttype=global')
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/addToWhitelist?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}

<#
.DESCRIPTION
Add-SecuronixAttributeToWhitelist prepares API parameters and requests Securonix to add an attribute to an Attribute whitelist.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WhitelistName
A required API Parameter, the name of the Attribute whitelist you want to add an entity to. This should match the target violation name based on your ViolationType: Policy name, ThreatModel name, or Functionality name.

.PARAMETER TenantName
A required API Parameter, the name of the tenant the whitelist belongs to.

.PARAMETER ViolationType
A required API Parameter, enter any of the following: "Policy", "ThreatModel", "Functionality"

.PARAMETER AttributeName
A required API Parameter, enter the name of the attribute being added. It is recommended to use the following parameters instead: -sourceip, -resourcetype, -transactionstring. May be the following types: 'source ip', 'resourcetype', 'transactionstring'.

.PARAMETER AttributeValue
The attribute value to add to an Attribute whitelist. Required for use with the AttributeName parameter.

.PARAMETER SourceIp
A required API Parameter, automatically specifies the AttributeName as source ip. Enter the ip address to add to the Attribute whitelist. 

.PARAMETER ResourceType
A required API Parameter, automatically specifies the AttributeName as resourcetype. Enter the resourcetype to add to the Attribute whitelist. 

.PARAMETER TransactionString
A required API Parameter, automatically specifies the AttributeName as transactionstring. Enter the transactionstring to add to the Attribute whitelist. 

.PARAMETER ExpiryDate
An optional API Parameter, enter the date Securonix will remove the entity from the whitelist. Format: MM/DD/YYYY

.INPUTS
None. You cannot pipe objects to Add-SecuronixAttributeToWhitelist.

.OUTPUTS
System.String. Add-SecuronixAttributeToWhitelist returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Add-SecuronixAttributeToWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'remote_users' -TenantName 'PA-Scranton' -ActivityaccountId 'jhalpert' -ResourceName 'dundermifflin_msft365_azuread' -ResourceGroupId '35' -ExpiryDate '05/16/2013'

.EXAMPLE
PS> Add-SecuronixAttributeToWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'infosec_servers' -TenantName 'NY-New_York_City' -ActivityipEntityId '192.168.1.55'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Whitelist/Add-SecuronixAttributeToWhitelist.md
#>
function Add-SecuronixAttributeToWhitelist {
    [CmdletBinding(
        DefaultParameterSetName='attributename',
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory,Position=0)]
		[string] $Url,
		[Parameter(Mandatory,Position=1)]
		[string] $Token,
        [Parameter(Mandatory,Position=2)]
		[string] $WhitelistName,
        [Parameter(Mandatory,Position=3)]
		[string] $TenantName,
        [Parameter(Mandatory,Position=4)]
        [ValidateSet('Policy', 'ThreatModel', 'Functionality')]
        [string] $ViolationType,
        [Parameter(ParameterSetName='attributename',
            Mandatory,
            Position=5
        )]
        [ValidateSet('source ip', 'resourcetype', 'transactionstring')]
		[string] $AttributeName,
        [Parameter(ParameterSetName='attributename',
            Mandatory,
            Position=6
        )]
        [string] $AttributeValue,
        [Parameter(ParameterSetName='sourceip',
            Mandatory
        )]
		[string] $SourceIp,
        [Parameter(ParameterSetName='resourcetype',
            Mandatory
        )]
		[string] $ResourceType,
        [Parameter(ParameterSetName='transactionstring',
            Mandatory
        )]
		[string] $TransactionString,
        [string] $ExpiryDate
	)

	Begin {
        if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

        if($AttributeName -eq '') {
            if($SourceIp -ne ''){
                $AttributeName = 'source ip'
                $AttributeValue = $SourceIp
                $PSBoundParameters.Remove('SourceIp') | Out-Null
            } 
            elseif ($ResourceType -ne '') {
                $AttributeName = 'resourcetype'
                $AttributeValue = $ResourceType
                $PSBoundParameters.Remove('ResourceType') | Out-Null
            } 
            elseif ($TransactionString -ne '') {
                $AttributeName = 'transactionstring'
                $AttributeValue = $TransactionString
                $PSBoundParameters.Remove('TransactionString') | Out-Null
            }

            $PSBoundParameters.Add('AttributeName',$AttributeName)
            $PSBoundParameters.Add('AttributeValue',$AttributeValue)
        }

        $Exclusions = @('Url', 'Token', 'WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        $paramsTable = @{
            'WhitelistName' = 'whitelistname'
            'TenantName' = 'tenantname'
            'AttributeName' ='attributename'
            'AttributeValue' = 'attributevalue'
            'ExpiryDate' = 'expirydate'
            'ViolationType' = 'violationtype'
		}

        $PSBoundParameters.Add('violationname', $WhitelistName)
		
        $paramsList = @('whitelisttype=attribute')
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/addToWhitelist?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}

<#
.DESCRIPTION
Get-SecuronixWhitelist prepares API parameters and requests Securonix to get a list of Whitelists.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WhitelistName
A required API Parameter, the name of the whitelist you want to find.

.PARAMETER TenantName
The name of the tenant the whitelist belongs to. This parameter is optional for non-MSSP.

.INPUTS
None. You cannot pipe objects to Get-SecuronixWhitelist.

.OUTPUTS
System.String. Get-SecuronixWhitelist returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixWhitelist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'remote_users' -TenantName 'PA-Scranton'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Whitelist/Get-SecuronixWhitelist.md
#>
function Get-SecuronixWhitelist {
    [CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token,
        [Parameter(Mandatory)]
		[string] $WhitelistName,
		[string] $TenantName
	)

	Begin {
        if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

        $Exclusions = @('Url', 'Token', 'WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        $paramsTable = @{
            'WhitelistName' = 'whitelistname'
            'TenantName' = 'tenantname'
		}
		
        $paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/getlistofWhitelist?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}

<#
.DESCRIPTION
Get-SecuronixWhitelistMembers prepares API parameters and requests Securonix to get the list of members for a Whitelist.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WhitelistName
A required API Parameter, the name of the whitelist you want to find.

.PARAMETER TenantName
A required API Parameter, the name of the tenant the whitelist belongs to.

.INPUTS
None. You cannot pipe objects to Get-SecuronixWhitelistMembers.

.OUTPUTS
System.String. Get-SecuronixWhitelistMembers returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Get-SecuronixWhitelistMembers -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WhitelistName 'remote_users' -TenantName 'PA-Scranton'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Whitelist/Get-SecuronixWhitelist.md
#>
function Get-SecuronixWhitelistMembers {
    [CmdletBinding(
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory)]
		[string] $Url,
		[Parameter(Mandatory)]
		[string] $Token,
        [Parameter(Mandatory)]
		[string] $WhitelistName,
        [Parameter(Mandatory)]
		[string] $TenantName
	)

	Begin {
        if($Url.EndsWith('/')) {
			$Url = $Url.Remove($Url.Length-1, 1)   
		}

		$Header = [ordered]@{
			'token' = $Token
		}

        $Exclusions = @('Url', 'Token', 'WhatIf', 'Confirm', 'Verbose')
        foreach($key in $Exclusions) {
            $PSBoundParameters.Remove($key) | Out-Null
        }

        $paramsTable = @{
            'WhitelistName' = 'whitelistname'
            'TenantName' = 'tenantname'
		}
		
        $paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}
		
		$Uri = "$Url/ws/incident/listWhitelistEntities?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}