Get-ADOptionalFeature -Filter {name -like "Privileged*"}

Enable-ADOptionalFeature 'Privileged Access Management Feature' -Scope ForestOrConfigurationSet -Target int.acme.com

Get-ADDomain int.acme.com 

#Add a user to a group for a specific amount of time
$TTL = New-TimeSpan -Minutes 1

Add-ADGroupMember -Identity testgroup -Members testuser2 -MemberTimeToLive $TTL

Get-ADGroupMember -Identity testgroup | select *