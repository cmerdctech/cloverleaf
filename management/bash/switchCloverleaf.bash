#!/bin/bash



if [[ "j" == "$1" ]]; then
fileName="cloverleafJmc"
echo "SET JMS";
cp $lightningPipeDir/system/config/$fileName.js $lightningPipeDir/system/config/cloverleaf.js
elif [[ "m" == "$1" ]]; then
fileName="cloverleafMssql"
echo "SET MSSQL"
cp $lightningPipeDir/system/config/$fileName.js $lightningPipeDir/system/config/cloverleaf.js
else
echo "NO CHANGE";
cat $lightningPipeDir/system/config/cloverleaf.js | grep userName
fi


