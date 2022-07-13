#Creating Users
New-ADUser -Surname 'Smith' -GivenName 'Richard' -Name 'Richard Smith' `
-DisplayName 'Richard Smith' -SamAccountName 'smithr' -UserPrincipalName 'smithr@int.acme.com' `
-Title 'Programmer' -Department 'IT' -City 'Toronto' -State 'Ontario' -Country 'CA' -EmployeeID '0001' `
-AccountPassword (ConvertTo-SecureString -String "Test1234!" -AsPlainText -Force) -Enabled:$true `
-Path (Get-ADOrganizationalUnit -Filter {name -like "Toronto1"})

#Another way to create a user, most recommended way 
$ADUser=@{
    Surname='Smith' 
    GivenName='Richard' 
    Name='Richard Smith'
    DisplayName='Richard Smith'
    SamAccountName='smithr'
    UserPrincipalName='smithr@int.acme.com'
    Title='Programmer' 
    Department='IT'
    City='Toronto'
    State='Ontario'
    Country='CA'
    EmployeeID='0001'
    AccountPassword=(ConvertTo-SecureString -String "Test1234!" -AsPlainText -Force) 
    Path=(Get-ADOrganizationalUnit -Filter {name -like "Toronto1"})
    Enabled=$true 
}

New-ADUser @ADUser

$GetADUser=Get-ADUser -Identity smithr -Properties *

#Changing a users information
$ADMod=@{
    City='New York'
    State='New York'
    Country='US'

}

$GetADUser | Set-ADUser @ADMod

#Moving a user to another OU
$MoveAD=@{
    TargetPath=(Get-ADOrganizationalUnit -Filter {name -like 'New York1'})
}

$GetADUser | Move-ADObject @MoveAD

#Resetting a Users Password
$GetADUser=Get-ADUser -Identity smithr -Properties *

$GetADUser | Set-ADAccountPassword -NewPassword (ConvertTo-SecureString -String "Password!1234" -AsPlainText -Force) -Reset
$GetADUser | Set-ADUser -ChangePasswordAtLogon:$true

#Removing a User 
$GetADUser | Remove-ADUser -Confirm:$false