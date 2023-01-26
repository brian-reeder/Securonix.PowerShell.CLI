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