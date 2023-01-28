# Get-SecuronixPolicyList
Get a list of Securonix policies.

## Syntax
```
Get-SecuronixPolicyList
    [-Url] <string>
    [-Token] <string>
```

Connection was set by Connect-SecuronixApi
```
Get-SecuronixPolicyList
```

## Description
Get-SecuronixPolicyList prepares API parameters and queries the Securonix for a list of all Policies.

## Examples

### Example 1: Get list of policies.

Request
```
Get-SecuronixPolicyList -Url 'DunderMifflin.securonix.com/Snypr' -Token '12345678-90AB-CDEF-1234-567890ABCDEF'
```

Response
```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?> 
<policies> 
	<policy> 
		<createdBy>admin</createdBy> 
		<createdOn>2013-11-09T16:13:23-06:00</createdOn> 
		<criticality>Low</criticality> 
		<description></description> 
		<hql> FROM AccessAccount AS accessaccount, Resources AS resources, AccessAccountUser AS accessaccountuser WHERE ((accessaccount.resourceid = resources.id AND accessaccountuser.id.accountid = accessaccount.id )) AND ((accessaccountuser.id.userid = '-1'))</hql> 
		<id>1</id> 
		<name>Accounts that dont have Users</name> 
	</policy> 
	<policy> 
		<createdBy>DocTeam</createdBy> 
		<createdOn>2013-11-09T16:31:09-06:00</createdOn> 
		<criticality>Medium</criticality> 
		<description></description> 
		<hql> FROM Users AS users, AccessAccountUser AS accessaccountuser, AccessAccount AS accessaccount, Resources AS resources WHERE ((users.id = accessaccountuser.id.userid AND accessaccountuser.id.accountid = accessaccount.id AND accessaccount.resourceid = resources.id )) AND ((users.status = '0'))</hql> 
		<id>2</id> 
		<name>Accounts that belong to terminated user</name> 
	</policy> 
</policies>
```

### Example 2: Connect to the Securonix Api and get list of policies.
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
<policies> 
	<policy> 
		<createdBy>admin</createdBy> 
		<createdOn>2013-11-09T16:13:23-06:00</createdOn> 
		<criticality>Low</criticality> 
		<description></description> 
		<hql> FROM AccessAccount AS accessaccount, Resources AS resources, AccessAccountUser AS accessaccountuser WHERE ((accessaccount.resourceid = resources.id AND accessaccountuser.id.accountid = accessaccount.id )) AND ((accessaccountuser.id.userid = '-1'))</hql> 
		<id>1</id> 
		<name>Accounts that dont have Users</name> 
	</policy> 
	<policy> 
		<createdBy>DocTeam</createdBy> 
		<createdOn>2013-11-09T16:31:09-06:00</createdOn> 
		<criticality>Medium</criticality> 
		<description></description> 
		<hql> FROM Users AS users, AccessAccountUser AS accessaccountuser, AccessAccount AS accessaccount, Resources AS resources WHERE ((users.id = accessaccountuser.id.userid AND accessaccountuser.id.accountid = accessaccount.id AND accessaccount.resourceid = resources.id )) AND ((users.status = '0'))</hql> 
		<id>2</id> 
		<name>Accounts that belong to terminated user</name> 
	</policy> 
</policies>
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