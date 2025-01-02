#!/bin/bash

## VARIABLES
### Your channels go here. add more channels as you want
numberofchannels=2
declare -a a0=("tvg-id-channel1" "VeroTV Test Channel" "Welcome to VeroTV" "Test programming used by our team. If you're seeing this on a live channel then please contact @VeroTVSupport on Telegram.")
declare -a a1=("tvg-id-channel2" "Christmas Movies" "Christmas Movies on VeroTV" "Join us in building the Christmas Spirit with 24/7 Christmas Movies on VeroTV. ")

starttimes=("000000" "020000" "040000" "060000" "080000" "100000" "120000" "140000" "160000" "180000" "200000" "220000")
endtimes=("020000" "040000" "060000" "080000" "100000" "120000" "140000" "160000" "180000" "200000" "220000" "235900")
BASEPATH="/your/folder/path"
DUMMYFILENAME=dummy.xml

		today=$(date +%Y%m%d)
		tomorrow=$(date --date="+1 day" +%Y%m%d)
		# tomorrow=$(date -v+1d +%Y%m%d)  ## if running on MAC or BSD
		echo '<?xml version="1.0" encoding="UTF-8"?>' > $BASEPATH/$DUMMYFILENAME
		echo '<tv generator-info-name="mydummy" generator-info-url="https://null.null/">' >> $BASEPATH/$DUMMYFILENAME
        numberofiterations=$(($numberofchannels - 1))
        echo "Creating Dummy Epg ..."


		for i in $(seq 0 $numberofiterations); do # Number of Dummys -1 
			tvgid=a$i[0]
			name=a$i[1]
			echo '    <channel id="'${!tvgid}'">' >> $BASEPATH/$DUMMYFILENAME
			echo '        <display-name lang="pt">'${!name}'</display-name>' >> $BASEPATH/$DUMMYFILENAME
			echo '    </channel>' >> $BASEPATH/$DUMMYFILENAME
		done

		for i in $(seq 0 $numberofiterations) ;do
			tvgid=a$i[0]
			title=a$i[2]
			desc=a$i[3]
			for j in $(seq 0 $((${#starttimes[@]} - 1))); do
					echo '    <programme start="'$today${starttimes[$j]}' +0000" stop="'$today${endtimes[$j]}' +0000" channel="'${!tvgid}'">' >> $BASEPATH/$DUMMYFILENAME
					echo '        <title lang="pt">'${!title}'</title>' >> $BASEPATH/$DUMMYFILENAME
					echo '        <desc lang="pt">'${!desc}'</desc>' >> $BASEPATH/$DUMMYFILENAME
					echo '    </programme>' >> $BASEPATH/$DUMMYFILENAME
			done
			for j in $(seq 0 $((${#starttimes[@]} - 1))); do
					echo '    <programme start="'$tomorrow${starttimes[$j]}' +0000" stop="'$tomorrow${endtimes[$j]}' +0000" channel="'${!tvgid}'">' >> $BASEPATH/$DUMMYFILENAME
					echo '        <title lang="pt">'${!title}'</title>' >> $BASEPATH/$DUMMYFILENAME
					echo '        <desc lang="pt">'${!desc}'</desc>' >> $BASEPATH/$DUMMYFILENAME
					echo '    </programme>' >> $BASEPATH/$DUMMYFILENAME
			done
		done

		echo '</tv>' >> $BASEPATH/$DUMMYFILENAME

echo "Done!"
sleep 2
