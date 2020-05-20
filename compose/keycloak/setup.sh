#!/bin/sh

/tmp/wait-for-it.sh keycloak:8443 -t 60

export PATH=$PATH:/opt/jboss/keycloak/bin

echo '>>> Logging into Keycloak'
kcadm.sh config credentials --server http://keycloak:8080/auth --realm master --user admin --password password

# This won't create another realm if one with this name exists
echo '>>> Creating applications realm'
kcadm.sh get realms/applications || kcadm.sh create realms -s realm=applications -s displayName=Applications -s enabled=true
