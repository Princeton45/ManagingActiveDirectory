#Creating an organizational Unit

$OUInfo=@{
    Name="Toronto1"
    Description="OU for office in Toronto"
}

New-ADOrganizationalUnit @OUInfo

#View an OU
#Get-ADOrganizationalUnit -Filter {name -eq "Toronto1"} -Properties * -Server int.acme.com 

#Deleting an OU

$OU=Get-ADOrganizationalUnit -Filter {name -eq "Toronto1"} -Properties * -Server int.acme.com 

$OU | Set-ADOrganizationalUnit -ProtectedFromAccidentalDeletion:$false

$OU | Remove-ADOrganizationalUnit -Confirm:$false

#Change the Name of an OU

$OU | Rename-ADObject -NewName "Canada" #Changed OU from "Toronto" to "Canada"

#Show all OU's
Get-ADOrganizationalUnit -Filter *

#Miscellanious for canada OU, putting description for the OU
$OU=Get-ADOrganizationalUnit -Filter {name -eq "Canada"} -Properties * -Server int.acme.com 

$OU | Set-ADOrganizationalUnit -Description "OU for Canada"