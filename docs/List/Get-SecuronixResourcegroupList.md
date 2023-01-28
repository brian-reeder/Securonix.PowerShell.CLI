# Get-SecuronixResourcegroupList
Get a list of Securonix resource groups.

## Syntax
```
Get-SecuronixResourcegroupList
    [-Url] <string>
    [-Token] <string>
```

Connection was set by Connect-SecuronixApi
```
Get-SecuronixResourcegroupList
```

## Description
Get-SecuronixResourcegroupList prepares API parameters and queries the Securonix for a list of all Resource Groups configured by Snypr for monitoring.

## Examples

### Example 1: Get list of resource groups.

Request
```
Get-SecuronixResourcegroupList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'
```

Response
```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?> 
<resourceGroups> 
	<resourceGroup> 
		<name>Bluecoat Proxy</name> 
		<type>Bluecoat Proxy</type> 
	</resourceGroup> 
	<resourceGroup> 
		<name>Ironport Data</name> 
		<type>Cisco Ironport Email</type> 
	</resourceGroup> 
	<resourceGroup> 
		<name>Windchill Data</name> 
		<type>Windchill</type> 
	</resourceGroup> 
</resourceGroups>
```

### Example 2: Connect to the Securonix Api and get list of resource groups.
```
Connect-SecuronixApi -Instance 'dundermifflin' `
    -Username 'MichaelBolton' -Password 'PiEcEsOfFlAiR'

Get-SecuronixPeerGroupsList
```

Responses
```
Connected
```

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?> 
<resourceGroups> 
	<resourceGroup> 
		<name>Bluecoat Proxy</name> 
		<type>Bluecoat Proxy</type> 
	</resourceGroup> 
	<resourceGroup> 
		<name>Ironport Data</name> 
		<type>Cisco Ironport Email</type> 
	</resourceGroup> 
	<resourceGroup> 
		<name>Windchill Data</name> 
		<type>Windchill</type> 
	</resourceGroup> 
</resourceGroups>
```

## Parameters

### -Url
Url endpoint for your Securonix instance.
It must be in the following format:
```
https://<hostname or IPaddress>/Snypr
```

### -Token
Valid authentication token.

## Links
[Securonix 6.4 REST API Categories - List](https://documentation.securonix.com/onlinedoc/Content/6.4%20Cloud/Content/SNYPR%206.4/6.4%20Guides/Web%20Services/6.4_REST%20API%20Categories.htm#List)