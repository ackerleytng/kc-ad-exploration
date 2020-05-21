# --------------------------------------------------------
#   Add Ruby group and User Zero, User One
# --------------------------------------------------------

New-ADGroup -Name "Ruby" -SamAccountName Ruby -GroupCategory Security -GroupScope Global -DisplayName "Ruby" -Path "CN=Users,DC=vdom,DC=local"

New-ADUser -Name "User Zero" -GivenName "User" -Surname "Zero" -SamAccountName "userzero" -UserPrincipalName "userzero@vdom.local" -Path "CN=Users,DC=vdom,DC=local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Ruby,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=User Zero,CN=Users,DC=vdom,DC=local")

New-ADUser -Name "User One" -GivenName "User" -Surname "One" -SamAccountName "userone" -UserPrincipalName "userone@vdom.local" -Path "CN=Users,DC=vdom,DC=local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Ruby,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=User One,CN=Users,DC=vdom,DC=local")

# --------------------------------------------------------
#   Add Sapphire group and User Two, User Three
# --------------------------------------------------------

New-ADGroup -Name "Sapphire" -SamAccountName Sapphire -GroupCategory Security -GroupScope Global -DisplayName "Sapphire" -Path "CN=Users,DC=vdom,DC=local"

New-ADUser -Name "User Two" -GivenName "User" -Surname "Two" -SamAccountName "usertwo" -UserPrincipalName "usertwo@vdom.local" -Path "CN=Users,DC=vdom,DC=local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Sapphire,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=User Two,CN=Users,DC=vdom,DC=local")

New-ADUser -Name "User Three" -GivenName "User" -Surname "Three" -SamAccountName "userthree" -UserPrincipalName "userthree@vdom.local" -Path "CN=Users,DC=vdom,DC=local" -AccountPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Enabled $true

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Sapphire,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=User Three,CN=Users,DC=vdom,DC=local")

# --------------------------------------------------------
#   Add Stones group and add Ruby, Sapphire as members
# --------------------------------------------------------

New-ADGroup -Name "Stones" -SamAccountName Stones -GroupCategory Security -GroupScope Global -DisplayName "Stones" -Path "CN=Users,DC=vdom,DC=local"

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Stones,CN=Users,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=Sapphire,CN=Users,DC=vdom,DC=local")

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Stones,CN=Users,DC=vdom,DC=local") -Members $(Get-ADGroup -Identity "CN=Ruby,CN=Users,DC=vdom,DC=local")

# --------------------------------------------------------
#   Add User Three and User One as members of group Odd
# --------------------------------------------------------

New-ADGroup -Name "Odd" -SamAccountName Odd -GroupCategory Security -GroupScope Global -DisplayName "Odd" -Path "CN=Users,DC=vdom,DC=local"

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Odd,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=User One,CN=Users,DC=vdom,DC=local")

Add-ADGroupMember -Identity $(Get-ADGroup -Identity "CN=Odd,CN=Users,DC=vdom,DC=local") -Members $(Get-ADUser -Identity "CN=User Three,CN=Users,DC=vdom,DC=local")


# To list all users
# Get-ADUser -LDAPFilter '(name=*)'