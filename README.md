# Integrating Keycloak with AD

## Provisioning

```
vagrant up
```

After it's up, we have to add AD DS

```
./vagrant-ssh.sh -c 'C:\vagrant\provision-00-adds.ps1'
```

And then Windows will automatically reboot, then we add users and groups

```
./vagrant-ssh.sh -c 'C:\vagrant\provision-01-add-users-groups.ps1'
```

## Adding User Federation in Keycloak

1. Go to User Federation
2. Select LDAP
3. Set the following (leave everything else as default):
   + Console Display Name: ad-ds
   + Import Users: On
   + Edit Mode: READ_ONLY
   + Sync Registrations: Off
   + Vendor: Active Directory
   + Username LDAP attribute: sAMAccountName (do a regular `ldapsearch` and see
     which field you wanna use)
   + RDN LDAP attribute: sAMAccountName
   + UUID LDAP attribute: objectGUID
   + User Object Classes: person, organizationalPerson, user
   + Connection URL: ldap://172.17.0.1:3389
   + Users DN: CN=users,DC=vdom,DC=local
   + Bind Type: simple
   + Enable StartTLS: Off
   + Bind DN: userzero@vdom.local
   + Bind Credential: P@ssword123
   + Custom User LDAP Filter: (userPrincipalName=*@vdom.local)
   + Search Scope: One Level
4. Save settings
5. Change username mapper, to map to the LDAP Attribute `sAMAccountName`
6. Switch back to ad-ds settings, click "Synchronize all users" - you should import 4 users.
7. Test signing in to keycloak with

```
userthree@vdom.local
P@ssword123
```

> I believe only the fields in Mappers are pulled

## SSH into the container

Get powershell

```
./vagrant-ssh.sh -c powershell
```

Get cmd

```
./vagrant-ssh.sh -c powershell
```

## Tips/Notes

Quick test using ldapsearch

```
ldapsearch -x -o ldif-wrap=no -h localhost -p 3389 -D 'userzero@vdom.local' -w 'P@ssword123' -b 'dc=vdom,dc=local'
```

Show all groups

```
ldapsearch -x -o ldif-wrap=no -h localhost -p 3389 -D 'userzero@vdom.local' -w 'P@ssword123' -b 'dc=vdom,dc=local' '(objectClass=group)'
```

List all users we created

```
ldapsearch -x -o ldif-wrap=no -h localhost -p 3389 -D 'userzero@vdom.local' -w 'P@ssword123' -b 'dc=vdom,dc=local' '(userPrincipalName=*vdom.local)'
```
