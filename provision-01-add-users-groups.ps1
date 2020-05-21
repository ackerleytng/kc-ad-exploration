# --------------------------------------------------------
#   Add special user for Keycloak
# --------------------------------------------------------

New-ADUser -Name "Keycloak" -GivenName "Keycloak" -Surname "Keycloak" -SamAccountName "keycloak" -UserPrincipalName "keycloak@vdom.local" -Path "CN=Users,DC=vdom,DC=local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true

# --------------------------------------------------------
#   Add Users
# --------------------------------------------------------

New-ADUser -Name "Zack Doe" -GivenName "Zack" -Surname "Doe" -SamAccountName "zackdoe" -UserPrincipalName "zackdoe@vdom.local" -Path "CN=Users,DC=vdom,DC=local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true
New-ADUser -Name "Alice Moe" -GivenName "Alice" -Surname "Moe" -SamAccountName "alicemoe" -UserPrincipalName "alicemoe@vdom.local" -Path "CN=Users,DC=vdom,DC=local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true
New-ADUser -Name "Bob Toe" -GivenName "Bob" -Surname "Toe" -SamAccountName "bobtoe" -UserPrincipalName "bobtoe@vdom.local" -Path "CN=Users,DC=vdom,DC=local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true
New-ADUser -Name "Charlie Zoe" -GivenName "Charlie" -Surname "Zoe" -SamAccountName "charliezoe" -UserPrincipalName "charliezoe@vdom.local" -Path "CN=Users,DC=vdom,DC=local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true
New-ADUser -Name "David Hoe" -GivenName "David" -Surname "Hoe" -SamAccountName "davidhoe" -UserPrincipalName "davidhoe@vdom.local" -Path "CN=Users,DC=vdom,DC=local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true

# --------------------------------------------------------
#   Add User Groups
# --------------------------------------------------------

New-ADGroup -Name "Devs" -SamAccountName "Devs" -GroupCategory Security -GroupScope Global -DisplayName "Devs" -Path "CN=Users,DC=vdom,DC=local"
New-ADGroup -Name "Appdev" -SamAccountName "Appdev" -GroupCategory Security -GroupScope Global -DisplayName "Appdev" -Path "CN=Users,DC=vdom,DC=local"
New-ADGroup -Name "Security" -SamAccountName "Security" -GroupCategory Security -GroupScope Global -DisplayName "Security" -Path "CN=Users,DC=vdom,DC=local"

# --------------------------------------------------------
#   Setup User Group Hierarchy
# --------------------------------------------------------

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Devs,CN=Users,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=Appdev,CN=Users,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Devs,CN=Users,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=Security,CN=Users,DC=vdom,DC=local")

# --------------------------------------------------------
#   Assign users to groups
# --------------------------------------------------------

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Devs,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=Zack Doe,CN=Users,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Security,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=Alice Moe,CN=Users,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Security,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=Bob Toe,CN=Users,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Appdev,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=Charlie Zoe,CN=Users,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Appdev,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=David Hoe,CN=Users,DC=vdom,DC=local")

# --------------------------------------------------------
#   Create fw_rule permissions
# --------------------------------------------------------

New-ADGroup -Name "fw_rule:read" -SamAccountName "fw_rule__read" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:read" -Path "CN=Users,DC=vdom,DC=local"
New-ADGroup -Name "fw_rule:approve" -SamAccountName "fw_rule__approve" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:approve" -Path "CN=Users,DC=vdom,DC=local"
New-ADGroup -Name "fw_rule:update" -SamAccountName "fw_rule__update" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:update" -Path "CN=Users,DC=vdom,DC=local"
New-ADGroup -Name "fw_rule:create" -SamAccountName "fw_rule__create" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:create" -Path "CN=Users,DC=vdom,DC=local"
New-ADGroup -Name "fw_rule:delete" -SamAccountName "fw_rule__delete" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:delete" -Path "CN=Users,DC=vdom,DC=local"

# --------------------------------------------------------
#   Create fw_rule roles
# --------------------------------------------------------

New-ADGroup -Name "fw_rule:reviewer" -SamAccountName "fw_rule__reviewer" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:reviewer" -Path "CN=Users,DC=vdom,DC=local"
New-ADGroup -Name "fw_rule:approver" -SamAccountName "fw_rule__approver" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:approver" -Path "CN=Users,DC=vdom,DC=local"
New-ADGroup -Name "fw_rule:changer" -SamAccountName "fw_rule__changer" -GroupCategory Security -GroupScope Global -DisplayName "fw_rule:changer" -Path "CN=Users,DC=vdom,DC=local"

# --------------------------------------------------------
#   Group permissions into roles
# --------------------------------------------------------

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:read,CN=Users,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:reviewer,CN=Users,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:read,CN=Users,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:approver,CN=Users,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:read,CN=Users,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:changer,CN=Users,DC=vdom,DC=local")

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:approve,CN=Users,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:approver,CN=Users,DC=vdom,DC=local")

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:update,CN=Users,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:changer,CN=Users,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:create,CN=Users,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:changer,CN=Users,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:delete,CN=Users,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=fw_rule:changer,CN=Users,DC=vdom,DC=local")

# --------------------------------------------------------
#   Assign roles to users or groups
# --------------------------------------------------------

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:changer,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=David Hoe,CN=Users,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:approver,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=Charlie Zoe,CN=Users,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:approver,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=Zack Doe,CN=Users,DC=vdom,DC=local")
Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=fw_rule:reviewer,CN=Users,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=Devs,CN=Users,DC=vdom,DC=local")
