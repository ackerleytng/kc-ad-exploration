# ------------------------------------------------
#   Add AD Domain services
# ------------------------------------------------

Add-WindowsFeature AD-Domain-Services -IncludeManagementTools

# Promote server to domain controller (Server will reboot on its own after this command executes)

Install-ADDSForest -DomainName vdom.local -SafeModeAdministratorPassword $(ConvertTo-SecureString 'P@ssword123' -AsPlainText -Force) -Force
