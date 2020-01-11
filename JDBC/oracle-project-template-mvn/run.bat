@echo off

set /P ORACLE_USER=Oracle database username: 

set /P ORACLE_PASS=Oracle database password: 

for %%f in (.\target\*.jar) do set jarFile=%%f
java -Dlogin=%ORACLE_USER% -Dpassword=%ORACLE_PASS% -jar %jarFile%
