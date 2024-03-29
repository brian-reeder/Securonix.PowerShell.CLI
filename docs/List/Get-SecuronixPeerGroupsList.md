# Get-SecuronixPeerGroupsList
Get a list of Securonix resource groups.

## Syntax
```
Get-SecuronixPeerGroupsList
    [-Url] <string>
    [-Token] <string>
```

Connection was set by Connect-SecuronixApi
```
Get-SecuronixPeerGroupsList
```

## Description
Get-SecuronixPeerGroupsList prepares API parameters and queries the Securonix for a list of all Peer Groups configured in the system.

## Examples

### Example 1: Get list of peer groups.

Request
```
Get-SecuronixPeerGroupsList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'
```

Response
```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<peerGroups>
	<peerGroup>
		<criticality>Low</criticality>
		<name>Advertising</name>
	</peerGroup>
	<peerGroup>
		<criticality>Low</criticality>
		<name>Branding</name>
	</peerGroup>
</peerGroups> 
```

### Example 2: Connect to the Securonix Api and get list of peer groups.
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
<peerGroups>
	<peerGroup>
		<criticality>Low</criticality>
		<name>Advertising</name>
	</peerGroup>
	<peerGroup>
		<criticality>Low</criticality>
		<name>Branding</name>
	</peerGroup>
</peerGroups> 
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