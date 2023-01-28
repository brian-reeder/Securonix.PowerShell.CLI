<#
.DESCRIPTION
Add-SecuronixEntityToWatchlist prepares API parameters and requests Securonix to list all watchlists an entity is a member of.

.PARAMETER Url
Url endpoint for your Securonix instance. Must be in the format https://<hostname or IPaddress>/Snypr

.PARAMETER Token
An API token to validate access. Use New-SecuronixApiToken to generate a new token.

.PARAMETER WatchlistName
A required API Parameter, the name of the watchlist to add entity membership.

.PARAMETER EntityType
A required API Parameter, enter the type of entity you are adding. May be the following types: 'Users', 'Activityaccount', 'Resource', 'Activityip'.

.PARAMETER EntityId
A required API Parameter, the unique id to find watchlist memberships for. If the entitytype is users, the entityid will be the employeeid.

.PARAMETER EntityIdList
A required API Parameter, a list of Entity Ids to add to a watch list. Max number of 5 at a time.

.PARAMETER UsersId
A requried API parameter, enter the id for the Users entity to be added to a watchlist. This parameter sets EntityType to Users.

.PARAMETER UsersIdList
A requried API parameter, enter a list of entity ids to be added to a watchlist. This parameter sets EntityType to Users.

.PARAMETER ActivityaccountId
A requried API parameter, enter the id for the Activityaccount entity to be added to a watchlist. This parameter sets EntityType to Activityaccount.

.PARAMETER ActivityaccountIdList
A requried API parameter, enter a list of entity ids to be added to a watchlist. This parameter sets EntityType to Activityaccount.

.PARAMETER ResourceId
A requried API parameter, enter the id for the Resource entity to be added to a watchlist. This parameter sets EntityType to Resource.

.PARAMETER ResourceIdList
A requried API parameter, enter a list of entity ids to be added to a watchlist. This parameter sets EntityType to Resource.

.PARAMETER ActivityIpId
A requried API parameter, enter the id for the Activityip entity to be added to a watchlist. This parameter sets EntityType to Activityip.

.PARAMETER ActivityIpIdList
A requried API parameter, enter a list of entity ids to be added to a watchlist. This parameter sets EntityType to ActivityIp.

.PARAMETER ExpiryDays
A required API Parameter, enter the number of days for the account to be on the watch list.

.PARAMETER ResourceGroupId
A required API Parameter, enter the resource group id that the entity will be monitored from. If the resource type is Users, this will be set to -1.

.INPUTS
None. You cannot pipe objects to Add-SecuronixEntityToWatchlist

.OUTPUTS
System.String. Add-SecuronixEntityToWatchlist returns the API response. The API will respond with a JSON object for valid requests.

.EXAMPLE
PS> Add-SecuronixEntityToWatchlist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WatchlistName 'Phished Users' -UsersId 'mscott' -ExpiryDays 90

.EXAMPLE
PS> Add-SecuronixEntityToWatchlist -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF' -WatchlistName 'Log4J Application Hosts' -ActivityIpIdList @('127.0.0.1','192.168.1.1','172.16.1.1','10.1.1.1','172.31.255.255') -EntityDays 90 -ResourceGroupId '83375'

.LINK
https://github.com/brian-reeder/Securonix.PowerShell.CLI/blob/main/Docs/Watchlist/Get-SecuronixEntityWatchlistList.md
#>
function Add-SecuronixEntityToWatchlist {
    [CmdletBinding(
        DefaultParameterSetName='single',
        PositionalBinding,
        SupportsShouldProcess
    )]
	param(
		[Parameter(Mandatory,Position=0)]
		[string] $Url,
		[Parameter(Mandatory,Position=1)]
		[string] $Token,
        [Parameter(Mandatory,Position=2)]
        [string] $WatchlistName,
        [Parameter(ParameterSetName='single',
            Mandatory,
            Position=3
        )]
        [Parameter(ParameterSetName='list',
            Mandatory,
            Position=3
        )]
        [ValidateSet('Users', 'Activityaccount', 'Resource', 'Activityip')]
		[string] $EntityType,
        [Parameter(ParameterSetName='single',
            Mandatory,
            Position=4
        )]
		[string] $EntityId,
        [Parameter(ParameterSetName='list',
            Mandatory,
            Position=4
        )]
        [ValidateCount(1,5)]
		[string[]] $EntityIdList,
        [Parameter(ParameterSetName='UsersId',Mandatory)]
		[string] $UsersId,
        [Parameter(ParameterSetName='UsersIdList',Mandatory)]
        [ValidateCount(1,5)]
		[string[]] $UsersIdList,
        [Parameter(ParameterSetName='ActivityaccountId',Mandatory)]
		[string] $ActivityaccountId,
        [Parameter(ParameterSetName='ActivityaccountIdList',Mandatory)]
        [ValidateCount(1,5)]
		[string[]] $ActivityaccountIdList,
        [Parameter(ParameterSetName='ResourceId',Mandatory)]
		[string] $ResourceId,
        [Parameter(ParameterSetName='ResourceIdList',Mandatory)]
        [ValidateCount(1,5)]
		[string[]] $ResourceIdList,
        [Parameter(ParameterSetName='ActivityIpId',Mandatory)]
		[string] $ActivityIpId,
        [Parameter(ParameterSetName='ActivityIpIdList',Mandatory)]
        [ValidateCount(1,5)]
		[string[]] $ActivityIpIdList,
        [Parameter(Mandatory)]
		[int] $ExpiryDays,
        [Parameter(ParameterSetName='single',Mandatory)]
        [Parameter(ParameterSetName='list',Mandatory)]
        [Parameter(ParameterSetName='ActivityaccountId', Mandatory)]
        [Parameter(ParameterSetName='ActivityaccountIdList', Mandatory)]
        [Parameter(ParameterSetName='ResourceId', Mandatory)]
        [Parameter(ParameterSetName='ResourceIdList', Mandatory)]
        [Parameter(ParameterSetName='ActivityIpId',Mandatory)]
        [Parameter(ParameterSetName='ActivityIpIdList',Mandatory)]
		[string] $ResourceGroupId
	)

	Begin {
        if($PSBoundParameters.Keys -notcontains 'EntityType') {
            if($UsersId -ne '') {
                $EntityType = 'Users';
                $EntityId = $PSBoundParameters['UsersId']
                $PSBoundParameters.Remove('UsersId') | Out-Null
            }
            elseif($ActivityaccountId -ne '') {
                $EntityType = 'Activityaccount';
                $EntityId = $PSBoundParameters['ActivityaccountId']
                $PSBoundParameters.Remove('ActivityaccountId') | Out-Null
            }
            elseif($ResourceId -ne '') {
                $EntityType = 'Resource';
                $EntityId = $PSBoundParameters['ResourceId']
                $PSBoundParameters.Remove('ResourcetId') | Out-Null
            }
            elseif($ActivityIpId -ne '') {
                $EntityType = 'Activityip';
                $EntityId = $PSBoundParameters['ActivityIpId']
                $PSBoundParameters.Remove('ActivityIpId') | Out-Null
            }
            elseif($UsersIdList.Count -gt 0) {
                $EntityType = 'Users'
                $EntityIdList = $PSBoundParameters['UsersIdList']
                $PSBoundParameters.Remove('UsersIdList') | Out-Null
            }
            elseif($ActivityaccountIdList.Count -gt 0) {
                $EntityType = 'Activityaccount'
                $EntityIdList = $PSBoundParameters['ActivityaccountIdList']
                $PSBoundParameters.Remove('ActivityaccountIdList') | Out-Null
            }
            elseif($ResourceIdList.Count -gt 0) {
                $EntityType = 'Resource'
                $EntityIdList = $PSBoundParameters['ResourceIdList']
                $PSBoundParameters.Remove('ResourceIdList') | Out-Null
            }
            elseif($ActivityIpIdList.Count -gt 0) {
                $EntityType = 'Activityip'
                $EntityIdList = $PSBoundParameters['ActivityIpIdList']
                $PSBoundParameters.Remove('ActivityIpIdList') | Out-Null
            }

            # Set Required API Params
            $PSBoundParameters.Add('EntityType', $EntityType)
            if($EntityId -ne '') {
                $PSBoundParameters.Add('EntityId', $UsersId)
            }
            elseif($EntityIdList.Count -gt 0) {
                $PSBoundParameters.Add('EntityIdList', $EntityIdList)
            }
        }

        if($EntityType -eq 'Users') {
            $PSBoundParameters['ResourceGroupId'] = '-1'
        }

        if ($EntityIdList.Count -gt 0) {
            $EntityId = $EntityIdList -join ','
            $PSBoundParameters.Add('EntityId', $EntityId)
            $PSBoundParameters.Remove('EntityIdList') | Out-Null
        }

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
            'EntityId' = 'entityId'
            'WatchlistName' = 'watchlistname'
            'EntityType' = 'entitytype'
            'ExpiryDays' = 'expirydays'
            'ResourceGroupId' = 'resourcegroupid'
		}

		$paramsList = @()
		foreach($param in $PSBoundParameters.Keys) {
            $Key = if($paramsTable.Keys -ccontains $param) { $paramsTable[$param] } else { $param }
			$paramsList += "$($Key)=$($PSBoundParameters[$param])"
		}

		$Uri = "$Url/ws/incident/addToWatchlist?$($paramsList -join '&')"
	}

	Process {
        if($PSCmdlet.ShouldProcess($Uri, 'REST Method')) {
            $response = Invoke-RestMethod -Uri $Uri -Headers $Header -Method Get
            return $response
        }
	}

	End {}
}