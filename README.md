# Integrating Keycloak with AD

## SSH into the container

Get powershell

```
./vagrant-ssh.sh -c powershell
```

Get cmd

```
./vagrant-ssh.sh -c powershell
```

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
