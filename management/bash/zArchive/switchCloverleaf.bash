#!/bin/bash



if [[ "j" == "$1" ]]; then
fileName="cloverleafJmc"
echo "SET JMS";
cp $CLOVERLEAF_BASE_PATH/config/debugProfiles/$fileName.js $CLOVERLEAF_BASE_PATH/config/cloverleaf.js

elif [[ "m" == "$1" ]]; then
fileName="cloverleafMssql"
echo "SET MSSQL"
cp $CLOVERLEAF_BASE_PATH/config/debugProfiles/$fileName.js $CLOVERLEAF_BASE_PATH/config/cloverleaf.js

elif [[ "s" == "$1" ]]; then
fileName="SFTP"
echo "SET SFTP"
cp $CLOVERLEAF_BASE_PATH/config/debugProfiles/$fileName.js $CLOVERLEAF_BASE_PATH/config/cloverleaf.js

elif [[ "l" == "$1" ]]; then
fileName="localSandbox"
echo "SET localSandbox"
cp $CLOVERLEAF_BASE_PATH/config/debugProfiles/$fileName.js $CLOVERLEAF_BASE_PATH/config/cloverleaf.js

else
echo "NO CHANGE";
cat $CLOVERLEAF_BASE_PATH/config/cloverleaf.js | grep userName;
echo -e " \n\
try: \n\
j - cloverleafJmc \n\
m - cloverleaf mysql \n\
s - server SFTP \n\
l - localSandbox \n\
";
fi


