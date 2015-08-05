#!/bin/bash
echo "CLOVERLEAF ALIASES ETC (editclscripts)";

export clTestInfo="\
----------------------------------\n\
TESTING COMMANDS\n\n\

pingLp - ping LP test server\n\

clRunner - Run Cloverleaf with a command that specifies all aspects of the run\n \
			also identify profiles and parameters\n\\n\
clJson - Run Cloverleaf against parameter file\n\n\
clswitchLogin - run Cloverleaf as a different client \n\n\
'cloverleaf -p' - gives you info about it's current setup\n\n\

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


if [ ! $updatedCommonCloverleafPath ]; then
export PATH=$PATH:"$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )": #include other executable scripts in this directory
export updatedCommonCloverleafPath='done'
fi

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
export cloverleafDir="$homeDir/testLinkpoint/cloverleafHome/system/cloverleaf"
export clLoggingDir="$homeDir/testLinkpoint/cloverleafHome/logFiles"

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
# --max_new_space_size (max size of the new generation (in kBytes))
# --max_old_space_size (max size of the old generation (in Mbytes))
# --max_executable_size (max size of executable memory (in Mbytes))

#memoryAllocation="--max-old-space-size=1024";
#memoryAllocation="--max-old-space-size=2048";
#memoryAllocation="--max-old-space-size=3072";
#memoryAllocation="--max-old-space-size=4096";
#memoryAllocation="--max-old-space-size=5120";
#memoryAllocation="--max-old-space-size=6144";
#memoryAllocation="--max-old-space-size=7168";
#memoryAllocation="--max-old-space-size=8192";
memoryAllocation="";

export cloverleaf="node $memoryAllocation $cloverleafDir/cloverleaf.js" #this seems to work better inside of scripts than an alias
alias cloverleaf="node $memoryAllocation $cloverleafDir/cloverleaf.js" #this is good on the command line so you don't have to type $


# === TEST RUNNING ===========================================
alias pingLp="curl http://127.0.0.1:8000/ping"

if [ "$serverContext" == "qbook" ]; then
alias viewLog="cat $clLoggingDir/lightningClover.log | bunyan | tail -c -10000; echo 'ANY FATAL?'; cat $clLoggingDir/lightningClover.log | bunyan -l fatal; echo 'done';"
else
alias viewLog="cat $clLoggingDir/lightningClover.log | bunyan | tail --lines=133; echo 'ANY FATAL?'; cat $clLoggingDir/lightningClover.log | bunyan -l fatal; echo 'done';"

fi

alias tailLog="tail -f -n 20 $clLoggingDir/lightningClover.log | bunyan"
alias killLog="rm $clLoggingDir/lightningClover.log"




