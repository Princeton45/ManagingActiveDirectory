#Creating a group 
New-ADGroup -Name "Test Group" -Description "This group has access to drive X:" -SamAccountName "testgroup" -GroupCategory Security -GroupScope Global

#Another way to create a group
$GroupData=@{
    Name="IT Group"
    Description="Group for all of IT"
    SamAccountname="itgroup"
    GroupCategory="Security"
    GroupScope="Global"
}

New-ADGroup @GroupData

$Group=Get-ADGroup -Filter {name -eq "Test Group"} -Properties *

#Adding a user to a group
$User=Get-ADUser -Identity testuser2
Add-ADGroupMember -Identity $Group -Members $User

#See whos the member of a group

#Get-ADGroupMember -Identity $Group

#Remove a user from the group

$usersInGroup=Get-ADGroupMember -Identity $Group

foreach($user in $usersInGroup){
    Remove-ADGroupMember -Identity $Group -Members $User -Confirm:$false
}

#Adding a group to another group
$Group=Get-ADGroup -Filter {name -eq "Test Group"} -Properties *
$Group2=Get-ADGroup -Filter {name -eq "IT Group"} -Properties *

#Now we'll add the test group into the IT group
Add-ADGroupMember -Identity $Group2 -Members $Group

#Remove a group
$Group=Get-ADGroup -Filter {name -eq "Test Group"} -Properties *
Remove-ADGroup  -Identity $Group -Confirm:$false