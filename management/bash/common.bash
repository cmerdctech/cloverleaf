#!/bin/bash
echo "CLOVERLEAF ALIASES ETC (editclscripts)";

export clTestInfo="\
----------------------------------\n\
TESTING COMMANDS\n\n\

pingLp - ping LP test server\n\

clSingle - Run Cloverleaf with specific parameters\n\
clCommands - Run Cloverleaf from shell script file\n\
   (\$clTestParametersDir/testCommandsDemo.bash)\n\\n\
clJson - Run Cloverleaf against parameter file\n\
   (\$clTestParametersDir/testJsonDemo.js)\n\\n\
cljmcUser - set Cloverleaf user to jmc\n\
clmssqlUser - set Cloverleaf usr to mssql\n\n\
'cloverleaf -p' - gives you info about it's current setup\n\

cldir - cd to Cloverleaf code\n\n\
clInfo - repeat this information\n\n\
viewLog - look at all log info\n\n\
tailLog - look at recent log info\n\n\
editclscripts - edit this file\n\
----------------------------------\n\
";

if [ ! -e "$clProjectBase/logFiles" ]
then
  echo -e "\ncreating $clProjectBase/logFiles\n"
  mkdir "$clProjectBase/logFiles"
fi

if [ ! -e "$clProjectBase/testResults" ]
then
  echo -e "\ncreating $clProjectBase/testResults\n"
  mkdir "$clProjectBase/testResults"
fi

if [ ! -e "$clProjectBase/config" ]
then
  echo -e "\nWARNING: $clProjectBase/config IS MISSING\n"
fi


echo -e "$clTestInfo";
alias clInfo=' echo -e "$clTestInfo"'
alias clTestDir="cd $clProjectBase/testResults"

export PATH=$PATH:"$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )": #include other executable scripts in this directory

echo -e "\ncd clProjectBase ======"; cd $clProjectBase; pwd; #note: this is a synonym of lprepo, repo is different in some other projects

# === symbolic link allows paths fixed in control files to be redirected for various test purposes ===
echo -e $dataLinkDir;

if [ ! -d "$dataLinkDir" ]; then
	echo -e "creating: $dataLinkDir";
	mkdir $dataLinkDir;
fi


if [ -e "$homeDir/testLinkpoint/cloverleafHome" ]; then
	rm $homeDir/testLinkpoint/cloverleafHome;
fi
if [ -e "$homeDir/testLinkpoint/clTestDataSource" ]; then
	rm $homeDir/testLinkpoint/clTestDataSource;
fi
if [ -e "$homeDir/testLinkpoint/clTestDataDest" ]; then
	rm $homeDir/testLinkpoint/clTestDataDest;
fi

ln -s $clProjectBase $homeDir/testLinkpoint/cloverleafHome

ln -s $homeDir/testLinkpoint/cloverleafHome/testDataFiles/ $homeDir/testLinkpoint/clTestDataSource; #for use in json files
ln -s $homeDir/testLinkpoint/cloverleafHome/testResults/ $homeDir/testLinkpoint/clTestDataDest; #for use in json files



# create environment variables for important locations ================================
export clSystemDir="$homeDir/testLinkpoint/cloverleafHome/system"
export cloverleafDir="$homeDir/testLinkpoint/cloverleafHome/system/cloverleaf"
export clLoggingDir="$homeDir/testLinkpoint/cloverleafHome/logFiles"


export clTestParametersDir="$clSystemDir/management/bash/parameterFiles"

export testDestDir="$homeDir/testLinkpoint/clTestDataDest"; #for use in bash files


if [ ! -d $clLoggingDir ]; then
echo -e "CREATING DIRECTORY: $clLoggingDir";
mkdir $clLoggingDir
fi
if [ ! -d $testDestDir ]; then
echo -e "CREATING DIRECTORY: $testDestDir";
mkdir $testDestDir
fi



# === UTILITY AND NAVIGATION aliases ===========================================
alias clrepo="cd $clProjectBase/system; pwd; git status;";
alias editclscripts="edit $clTestScriptsDir/common.bash"

alias cldir="cd $cloverleafDir; echo -e '\n'; ls -la; pwd;"


# === BASIC OPERATION aliases/variables ===========================================
export cloverleaf="node $cloverleafDir/cloverleaf.js" #this seems to work better inside of scripts than an alias
alias cloverleaf="node $cloverleafDir/cloverleaf.js" #this is good on the command line so you don't have to type $


# === TEST RUNNING ===========================================
alias pingLp="curl http://127.0.0.1:8000/ping"

alias execCloverleaf="execCloverleaf.bash"
alias cljsontest="$cloverleaf -f $clTestParametersDir/testJsonDemo.js"

#change cloverleaf configuration to set user
alias cljmcUser="cp $clSystemDir/config/cloverleafJmc.js $clSystemDir/config/cloverleaf.js; echo 'SET JMC';"
alias clmssqlUser="cp $clSystemDir/config/cloverleafMssql.js $clSystemDir/config/cloverleaf.js; echo 'SET MSSQL';"

if [ "$serverContext" == "qbook" ]; then
alias viewLog="cat $clLoggingDir/lightningClover.log | bunyan | tail -c -10000; echo 'ANY FATAL?'; cat $clLoggingDir/lightningClover.log | bunyan -l fatal; echo 'done';"
else
alias viewLog="cat $clLoggingDir/lightningClover.log | bunyan | tail --lines=133; echo 'ANY FATAL?'; cat $clLoggingDir/lightningClover.log | bunyan -l fatal; echo 'done';"

fi

alias tailLog="tail -f $clLoggingDir/lightningClover.log | bunyan"
alias killLog="rm $clLoggingDir/lightningClover.log"




