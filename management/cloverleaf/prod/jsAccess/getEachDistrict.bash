#!/bin/bash


districtNames[0]='Albany';
districtNames[1]='Clinton-Graceville';
districtNames[2]='Hancock';
districtNames[3]='Morris';
districtNames[4]='Paynesville';
districtNames[5]='WCE';
districtNames[6]='Wheaton';


districtNames[7]='Barnesville';
districtNames[8]='Hawley';
districtNames[9]='Upsala';git
#districtNames[10]='Badger';
districtNames[11]='Browns-Valley';
districtNames[12]='Ulen-Hitterdahl';


shopt -s extglob

cloverProd="node /home/lightningpipe/lpProd/services/system/cloverleaf/cloverleaf.js"
TARGETDIR="/home/lightningpipe/mountPoint/destDirProd"
scriptDir=~/lpProd/services/system/management/cloverleaf/prod/jsAccess/districtAccessFiles;

echo -e "\n\n"`date` " Starting Run ============================";


for DISTRICTNAME in ${districtNames[*]}; do

 	targetPath="$TARGETDIR/$DISTRICTNAME/";

# 	echo -e "\n\nJSON FILE: $scriptDir/$DISTRICTNAME.js"; ls -la "$scriptDir/$DISTRICTNAME.js";
# 	echo -e "\n\nDESTDIR: $targetPath"; ls -la $targetPath;
# 	echo -e "\n\$cloverProd -fq $scriptDir/$DISTRICTNAME.js -v";

	[ -d $targetPath ] && cd $targetPath && rm !(Staff.txt)
	echo -e `date` " Executing $DISTRICTNAME ($targetPath)";
	$cloverProd -fq $scriptDir/$DISTRICTNAME.js

done



for DISTRICTNAME in ${districtNames[*]}; do
	targetPath="$TARGETDIR/$DISTRICTNAME/";
	echo -e "\n\n$targetPath\n";
	ls -la $targetPath
done
        
echo -e `date` " Ending Run ============================\n\n";