# --------------------------------------------------------
#   Add special user for Keycloak
# --------------------------------------------------------

New-ADUser -Name "Keycloak" -GivenName "Keycloak" -Surname "Keycloak" -SamAccountName "keycloak" -UserPrincipalName "keycloak@vdom.local" -Path "CN=Users,DC=vdom,DC=local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true

# --------------------------------------------------------
#   Add OUs for this setup
# --------------------------------------------------------

New-ADOrganizationalUnit -Name "Organization Structure" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "Permissions" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "Roles" -ProtectedFromAccidentalDeletion $false

# --------------------------------------------------------
#   Add Users
# --------------------------------------------------------

New-ADUser -Name "Zack Doe" -GivenName "Zack" -Surname "Doe" -SamAccountName "zackdoe" -UserPrincipalName "zackdoe@vdom.local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true -Path "OU=Organization Structure,DC=vdom,DC=local"
New-ADUser -Name "Alice Moe" -GivenName "Alice" -Surname "Moe" -SamAccountName "alicemoe" -UserPrincipalName "alicemoe@vdom.local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true -Path "OU=Organization Structure,DC=vdom,DC=local"
New-ADUser -Name "Bob Toe" -GivenName "Bob" -Surname "Toe" -SamAccountName "bobtoe" -UserPrincipalName "bobtoe@vdom.local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true -Path "OU=Organization Structure,DC=vdom,DC=local"
New-ADUser -Name "Charlie Zoe" -GivenName "Charlie" -Surname "Zoe" -SamAccountName "charliezoe" -UserPrincipalName "charliezoe@vdom.local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true -Path "OU=Organization Structure,DC=vdom,DC=local"
New-ADUser -Name "David Hoe" -GivenName "David" -Surname "Hoe" -SamAccountName "davidhoe" -UserPrincipalName "davidhoe@vdom.local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true -Path "OU=Organization Structure,DC=vdom,DC=local"

# --------------------------------------------------------
#   Add User Groups
# --------------------------------------------------------

New-ADGroup -Name "Devs" -SamAccountName "Devs" -GroupCategory Security -GroupScope Global -DisplayName "Devs" -Path "OU=Organization Structure,DC=vdom,DC=local"
New-ADGroup -Name "Appdev" -SamAccountName "Appdev" -GroupCategory Security -GroupScope Global -DisplayName "Appdev" -Path "OU=Organization Structure,DC=vdom,DC=local"
New-ADGroup -Name "Security" -SamAccountName "Security" -GroupCategory Security -GroupScope Global -DisplayName "Security" -Path "OU=Organization Structure,DC=vdom,DC=local"

# --------------------------------------------------------
#   Setup User Group Hierarchy
# --------------------------------------------------------

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Devs,OU=Organization Structure,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=Appdev,OU=Organization Structure,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Devs,OU=Organization Structure,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=Security,OU=Organization Structure,DC=vdom,DC=local")

# --------------------------------------------------------
#   Assign users to groups
# --------------------------------------------------------

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Devs,OU=Organization Structure,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=Zack Doe,OU=Organization Structure,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Security,OU=Organization Structure,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=Alice Moe,OU=Organization Structure,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Security,OU=Organization Structure,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=Bob Toe,OU=Organization Structure,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Appdev,OU=Organization Structure,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=Charlie Zoe,OU=Organization Structure,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Appdev,OU=Organization Structure,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=David Hoe,OU=Organization Structure,DC=vdom,DC=local")

# --------------------------------------------------------
#   Create fw_rule permissions
# --------------------------------------------------------

New-ADGroup -Name "fw_rule:read" -SamAccountName "fw_rule__read" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:read" -Path "OU=Permissions,DC=vdom,DC=local"
New-ADGroup -Name "fw_rule:approve" -SamAccountName "fw_rule__approve" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:approve" -Path "OU=Permissions,DC=vdom,DC=local"
New-ADGroup -Name "fw_rule:update" -SamAccountName "fw_rule__update" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:update" -Path "OU=Permissions,DC=vdom,DC=local"
New-ADGroup -Name "fw_rule:create" -SamAccountName "fw_rule__create" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:create" -Path "OU=Permissions,DC=vdom,DC=local"
New-ADGroup -Name "fw_rule:delete" -SamAccountName "fw_rule__delete" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:delete" -Path "OU=Permissions,DC=vdom,DC=local"

# --------------------------------------------------------
#   Create fw_rule roles
# --------------------------------------------------------

New-ADGroup -Name "fw_rule:reviewer" -SamAccountName "fw_rule__reviewer" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:reviewer" -Path "OU=Roles,DC=vdom,DC=local"
New-ADGroup -Name "fw_rule:approver" -SamAccountName "fw_rule__approver" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:approver" -Path "OU=Roles,DC=vdom,DC=local"
New-ADGroup -Name "fw_rule:changer" -SamAccountName "fw_rule__changer" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:changer" -Path "OU=Roles,DC=vdom,DC=local"

# --------------------------------------------------------
#   Group permissions into roles
# --------------------------------------------------------

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:read,OU=Permissions,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:reviewer,OU=Roles,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:read,OU=Permissions,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:approver,OU=Roles,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:read,OU=Permissions,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:changer,OU=Roles,DC=vdom,DC=local")

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:approve,OU=Permissions,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:approver,OU=Roles,DC=vdom,DC=local")

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:update,OU=Permissions,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:changer,OU=Roles,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:create,OU=Permissions,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:changer,OU=Roles,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:delete,OU=Permissions,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:changer,OU=Roles,DC=vdom,DC=local")

# --------------------------------------------------------
#   Assign roles to users or groups
# --------------------------------------------------------

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:changer,OU=Roles,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=David Hoe,OU=Organization Structure,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:approver,OU=Roles,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=Charlie Zoe,OU=Organization Structure,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:approver,OU=Roles,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=Zack Doe,OU=Organization Structure,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:reviewer,OU=Roles,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=Devs,OU=Organization Structure,DC=vdom,DC=local")
