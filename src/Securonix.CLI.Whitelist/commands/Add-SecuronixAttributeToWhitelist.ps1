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