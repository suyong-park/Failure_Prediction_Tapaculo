#!/bin/bash

# --------------- API Key & API Secret 검증 ---------------
echo -e "\nChecking your device info for testing your device deviation."
echo "Please enter your information"
echo -n "api_key : "
read api_key
echo -n "api_secret : "
read api_secret

echo
curl -d  "api_key=$api_key&api_secret=$api_secret" -X POST https://oa.tapaculo365.com/tp365/v1/account/check | jq . > check.json
echo

verify_api=$(jq .status check.json)

if [ $verify_api == true ]; then
	echo "VERIFY SUCCESS !!!"
	echo "NEXT STEP."
else
	echo "VERIFY FAIL !!!"
	echo "PLEASE CHECK YOUR API KEY AND API SECRET"
	echo "SHELL SCRIPT IS DONE."
	exit
fi
echo
# ----------------------------------------------------------


# --------------- 해당 회원사가 보유한 모든 채널 목록과 현재값을 가져옴 ---------------
echo "Get the list and current value of all channels owned by yours. Please enter device info."
echo -n "search channel(device name, model name, MAC address, node address, channel name) : "
read search_channel

echo
curl -d  "api_key=$api_key&api_secret=$api_secret&search=$search_channel" -X POST https://oa.tapaculo365.com/tp365/v1/channel/get_lst | jq . > channel_get_lst.json
echo
# --------------------------------------------------------------------------------------


# --------------- 지정 노드의 과거 시간 데이터 ----------------
echo "Get historical time data for the specified node."

echo "Please enter your data Start Time like 'yyyy-MM-dd-HH-mm-ss'"
start_time=`java trans_timestamp`
while [[ "$start_time" =~ "ERROR" ]]
do
        echo "TIMESTAMP ERROR !!!"
        echo "PLEASE CHECK YOUR TIMESTAMP"
        echo "PLEASE RE - ENTER START_TIME"
        start_time=`java trans_timestamp`
done

echo

echo "Please enter your data End Time like 'yyyy-MM-dd-HH-mm-ss'"
end_time=`java trans_timestamp`
while [[ "$end_time" =~ "ERROR" ]]
do
        echo "TIMESTAMP ERROR !!!"
        echo "PLEASE CHECK YOUR TIMESTAMP"
        echo "PLEASE RE - ENTER END_TIME"
        end_time=`java trans_timestamp`
done

echo

echo -n "device mac address(example : VIRTUAL_ALEX1002) : "
read device_mac_his
echo -n "sensor mac address(example : 000049D9E4) : "
read sensor_mac_his

echo
curl -d  "api_key=$api_key&api_secret=$api_secret&device_mac=$device_mac_his&sensor_mac=$sensor_mac_his&start_time=$start_time&end_time=$end_time" -X POST https://oa.tapaculo365.com/tp365/v1/channel/get_olddata | jq . > get_olddata.json
echo
# -----------------------------------------------------------


# --------------- 지정 노드의 24시간 데이터 ----------------
echo "Get last 24 hours data for the specified node."
echo -n "device mac address(example : VIRTUAL_ALEX1002) : "
read device_mac_24
echo -n "sensor mac address(example : 000049D9E4) : "
read sensor_mac_24

echo
curl -d  "api_key=$api_key&api_secret=$api_secret&device_mac=$device_mac_24&sensor_mac=$sensor_mac_24" -X POST https://oa.tapaculo365.com/tp365/v1/channel/get_recentdata | jq . > get_recentdata.json
echo
# -----------------------------------------------------------


# --------------- 지정 채널의 현재값을 가져옴 ----------------
echo "Get the current value of the specified channel. Please enter sensor id."
echo -n "sensor id(example : D123456-0000D123456-CH1) : "
read sensor_id

echo
curl -d  "api_key=$api_key&api_secret=$api_secret&sensor_id=$sensor_id" -X POST https://oa.tapaculo365.com/tp365/v1/channel/get_value | jq . > get_value.json
echo
# -----------------------------------------------------------


# --------------- 여러 개의 지정 채널 값을 한꺼번에 가져옴 ----------------
echo "Get multiple specified channel values at once. Please enter sensors (using ',')."
echo -n "sensors(example : VIRTUAL_ALEX1002-000049D9E4-CH1,VIRTUAL_ALEX1002-00006BF2B0-CH1) : "
read sensors

echo
curl -d  "api_key=$api_key&api_secret=$api_secret&sensors=$sensors" -X POST https://oa.tapaculo365.com/tp365/v1/channel/get_values | jq . > get_values.json
echo
# -------------------------------------------------------------------------


# --------------- 특정 장치 정보를 가져옴 ----------------
echo "Get specific device information. Please enter device MAC."
echo -n "MAC(example : VIRTUAL_ALEX1002) : "
read mac

echo
curl -d  "api_key=$api_key&api_secret=$api_secret&MAC=$mac" -X POST https://oa.tapaculo365.com/tp365/v1/device/get_info | jq . > get_info.json
echo
# ---------------------------------------------------------


# --------------- 장치 목록을 가져옴 ----------------
echo "Get device list. Please enter device info."
echo -n "search(device name, model name, MAC address) : "
read search

echo
curl -d  "api_key=$api_key&api_secret=$api_secret&search=$search" -X POST https://oa.tapaculo365.com/tp365/v1/device/get_lst | jq . > get_lst.json
echo
# ---------------------------------------------------


mv check.json channel_get_lst.json get_info.json get_lst.json get_olddata.json get_recentdata.json get_value.json get_values.json json/