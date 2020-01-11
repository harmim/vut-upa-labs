#!/bin/sh

echo -n "Oracle database username: "
read ORACLE_USER

echo -n "Oracle database password: "
read -s ORACLE_PASS

mvn package $@
exec java "-Dlogin=${ORACLE_USER}" "-Dpassword=${ORACLE_PASS}" -jar ./target/*.jar
