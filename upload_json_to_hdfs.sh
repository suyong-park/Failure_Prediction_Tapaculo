#!/bin/bash

is_running=`jps`

echo
is_true=1

if [[ $is_running == *"Jps"* ]]; then
	echo SUCCESS > /dev/null 2>&1
else
	is_true=0
fi
if [[ $is_running == *"NameNode"* ]]; then
	echo SUCCESS > /dev/null 2>&1
else
        is_true=0
fi
if [[ $is_running == *"SecondaryNameNode"* ]]; then
	echo SUCCESS > /dev/null 2>&1
else
        is_true=0
fi
if [[ $is_running == *"JobTracker"* ]]; then
	echo SUCCESS > /dev/null 2>&1
else
        is_true=0
fi
if [[ $is_running == *"TaskTracker"* ]]; then
	echo SUCCESS > /dev/null 2>&1
else
        is_true=0
fi
if [[ $is_running == *"DataNode"* ]]; then
        echo SUCCESS > /dev/null 2>&1
else
        is_true=0
fi

if [[ $is_true -eq 0 ]]; then
	echo "Hadoop Running ..."
        ./../bin/start-all.sh
        echo "DONE ! "
	echo
fi


echo "Please Wait ... Safemode off ..."
./../bin/hadoop dfsadmin -safemode leave
echo

echo "Json File Uploading ... "
./../bin/hadoop fs -put json json
echo
echo "Done !"
echo
echo "Let's see !"
echo
./../bin/hadoop fs -ls json