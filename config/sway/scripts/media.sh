#!/usr/bin/env bash

if [[ $# = 1 && $1 = '-h' ]]; then
    echo "$0 [next|previous|pause|play|stop|forward|back|loop|shuffle|player]"
    exit 1
fi
### This is primarily just a frontend for playerctl that does notifications.
# Usage:
#   playerctl [OPTION…] COMMAND - Controller for media players
# 
#   For players supporting the MPRIS D-Bus specification
# 
# Help Options:
#   -h, --help                     Show help options
# 
# Application Options:
#   -p, --player=NAME              A comma separated list of names of players to control (default: the first available player)
#   -a, --all-players              Select all available players to be controlled
#   -i, --ignore-player=IGNORE     A comma separated list of names of players to ignore.
#   -f, --format                   A format string for printing properties and metadata
#   -F, --follow                   Block and append the query to output when it changes for the most recently updated player.
#   -l, --list-all                 List the names of running players that can be controlled
#   -s, --no-messages              Suppress diagnostic messages
#   -v, --version                  Print version information
# 
# Available Commands:
#   play                    Command the player to play
#   pause                   Command the player to pause
#   play-pause              Command the player to toggle between play/pause
#   stop                    Command the player to stop
#   next                    Command the player to skip to the next track
#   previous                Command the player to skip to the previous track
#   position [OFFSET][+/-]  Command the player to go to the position or seek forward/backward OFFSET in seconds
#   volume [LEVEL][+/-]     Print or set the volume to LEVEL from 0.0 to 1.0
#   status                  Get the play status of the player
#   metadata [KEY...]       Print metadata information for the current track. If KEY is passed,
#                           print only those values. KEY may be artist,title, album, or any key found in the metadata.
#   open [URI]              Command for the player to open given URI.
#                           URI can be either file path or remote URL.
#   loop [STATUS]           Print or set the loop status.
#                           Can be "None", "Track", or "Playlist".
#   shuffle [STATUS]        Print or set the shuffle status.
#                           Can be "On", "Off", or "Toggle".

# notify-send media-playback-stop -t 60000 -i media-playback-stop; notify-send media-playback-pause -t 60000 -i media-playback-pause; notify-send media-eject -t 60000 -i media-eject; notify-send media-playback-start -t 60000 -i media-playback-start; notify-send media-skip-forward -t 60000 -i media-skip-forward; notify-send media-seek-forward -t 60000 -i media-seek-forward; notify-send media-seek-backward -t 60000 -i media-seek-backward; notify-send media-skip-backward -t 60000 -i media-skip-backward; notify-send media-view-subtitles -t 60000 -i media-view-subtitles; notify-send media-record -t 60000 -i media-record; notify-send media-playlist-consecutive -t 60000 -i media-playlist-consecutive; notify-send media-playlist-shuffle -t 60000 -i media-playlist-shuffle; notify-send media-playlist-repeat -t 60000 -i media-playlist-repeat; notify-send media-playlist-repeat-song -t 60000 -i media-playlist-repeat-song;

# notify-send media-playback-stop -t 60000 -i media-playback-stop;
# notify-send media-playback-pause -t 60000 -i media-playback-pause;
# notify-send media-eject -t 60000 -i media-eject;
# notify-send media-playback-start -t 60000 -i media-playback-start;
# notify-send media-skip-forward -t 60000 -i media-skip-forward;
# notify-send media-seek-forward -t 60000 -i media-seek-forward;
# notify-send media-seek-backward -t 60000 -i media-seek-backward;
# notify-send media-skip-backward -t 60000 -i media-skip-backward;
# notify-send media-view-subtitles -t 60000 -i media-view-subtitles;
# notify-send media-record -t 60000 -i media-record;
# notify-send media-playlist-consecutive -t 60000 -i media-playlist-consecutive;
# notify-send media-playlist-shuffle -t 60000 -i media-playlist-shuffle;
# notify-send media-playlist-repeat -t 60000 -i media-playlist-repeat;
# notify-send media-playlist-repeat-song -t 60000 -i media-playlist-repeat-song;

declare -a players=()

for plyr in $(playerctl -l)
do
	players+=($plyr)
	echo $plyr
done

if [ -f "/tmp/MEDIA_PLAYER_ID_$USER" ]
then
	_CONTROL=$(cat "/tmp/MEDIA_PLAYER_ID_$USER")
	
	
	for i in "${!players[@]}"
	do
	  pl=${players[$i]}
	  echo "$pl == $_CONTROL"
	  if [[ "$pl" == "$_CONTROL" ]]
	  then
	  	CONTROL=$_CONTROL
	  fi
	done
fi
if [ "" == "$CONTROL" ]
then
	if [ -n "$(pgrep firefox)" ];
	then
		CONTROL=$(playerctl -l | grep firefox | head -n 1)
	fi
	if [ -n "$(pgrep chrome)" ];
	then
		CONTROL=$(playerctl -l | grep chrome | head -n 1)
	fi
	if [ -n "$(pgrep strawberry)" ];
	then
		CONTROL="strawberry"
	fi
fi


echo $1
ACT=$1

if [ "$ACT" == "player" ]
then
	STATUS=$(playerctl --player=$CONTROL status)
	PLAYING=0
	if [ "$STATUS" == "Playing" ];
	then
		PLAYING=1
		playerctl --player=$CONTROL pause
	fi
	cur_i=-1
	for i in "${!players[@]}"; do
		echo "$i=${players[$i]}"
		if [[ "${players[$i]}" = "${CONTROL}" ]];
		then
			cur_i=$i
			break;
		fi
	done
	echo "${#players[@]}"
	echo "$(($cur_i + 1))"
	cur_i=$((($cur_i + 1)%${#players[@]}))
	echo "$(($cur_i + 1))"
	echo ${players[$cur_i]}
	CONTROL="${players[$cur_i]}"
	echo ${players[$cur_i]} > /tmp/MEDIA_PLAYER_ID_$USER
	ACT=""
	if [ "$PLAYING" == "1" ];
	then
		playerctl --player=$CONTROL play
	fi
fi

if [ "" != "$CONTROL" ]
then
	PLAYER="--player=$CONTROL"
fi

if [[ "$ACT" == "play-pause" ]]
then
	echo GETTING STATUS because $ACT
	STATUS=$(playerctl $PLAYER status)
	if [[ "$STATUS" == "Playing" ]];
	then
		ACT="pause"
	else
		ACT="play"
	fi
fi



echo $PLAYER
echo $ACT
if [[ "$ACT" != "" ]];
then
	case $ACT in 
			player)
						cur_i=-1
						for i in "${!players[@]}"; do
							echo "$i=${players[$i]}"
							if [[ "${players[$i]}" = "${CONTROL}" ]];
							then
								cur_i=$i
								break;
							fi
						done
						echo "${#players[@]}"
						echo "$(($cur_i + 1))"
						cur_i=$((($cur_i + 1)%${#players[@]}))
						echo "$(($cur_i + 1))"
						echo ${players[$cur_i]}
						CONTROL="${players[$cur_i]}"
						echo ${players[$cur_i]} > /tmp/MEDIA_PLAYER_ID_$USER
						;;
			next)		
						playerctl $PLAYER next
						ICON="media-skip-forward"
						;;
			previous)	
						playerctl $PLAYER previous
						ICON="media-skip-backward"
						;;
			pause)		
						playerctl $PLAYER pause
						ICON="media-playback-pause"
						;;
			play)		
						playerctl $PLAYER play
						ICON="media-playback-start"
						;;
			forward)	
						playerctl $PLAYER position 5+
						ICON="media-seek-forward"
						;;
			back)	
						playerctl $PLAYER position 5-
						ICON="media-seek-backward"
						;;
			wayforward)	
						playerctl $PLAYER position 15+
						ICON="media-seek-forward"
						;;
			wayback)	
						playerctl $PLAYER position 15-
						ICON="media-seek-backward"
						;;
			stop)		
						playerctl $PLAYER stop
						ICON="media-playback-stop"
						;;
			loop)		STATUS=$(playerctl $PLAYER loop)
						case $STATUS in
						"None") STATUS=playlist;;
						"Playlist") STATUS=track;;
						"Track") STATUS=none;;
						esac
						echo $STATUS
						playerctl $PLAYER loop $STATUS
						STATUS=$(playerctl $PLAYER loop)
						case $STATUS in 
						"None") 
							ICON="media-playback-start"
							;;
						"Playlist") 
							ICON="media-playlist-repeat"
							;;
						"Track") 
							ICON="media-playlist-repeat-song"
							;;
						esac
						;;
			shuffle)	playerctl $PLAYER shuffle toggle
						STATUS=$(playerctl $PLAYER shuffle)
						case $STATUS in
							On)
								ICON="media-playlist-shuffle";;
							Off)
								ICON="media-playback-start";;
						esac
						;;
	esac
else
	LOOP=$(playerctl $PLAYER loop)
	SHUFFLE=$(playerctl $PLAYER shuffle)
	STATUS=$(playerctl $PLAYER status)
	if [[ "$STATUS" == "Playing" ]];
	then
		ICON="media-playback-start"
		if [[ "$LOOP" == "Track" ]];
		then
			ICON="media-playlist-repeat-song"
		else
			case "$SHUFFLE" in
				"On")
					ICON="media-playlist-shuffle"
					;;
				"Off")
					if [[ "$LOOP" -eq "Playlist" ]];
					then
						ICON="media-playlist-repeat"
					fi
			esac
		fi
	elif [[ "$STATUS" == "Stopped" ]]
	then
		ICON="media-playback-stop"
	elif [[ "$STATUS" == "Paused" ]]
	then
		ICON="media-playback-pause"
	fi
fi

# function showStatus() 
# {
# 	# if [ -f "/tmp/MEDIA_NOTIFY_ID_$USER" ];
# 	# then
# 	# 	OLD_NOTIFY_ID="$(cat /tmp/MEDIA_NOTIFY_ID_$USER)"
# 	# 	notify-send $OLD_NOTIFY_ID -t 1 "end"
# 	# fi
	
# 	TITLE="$(playerctl $PLAYER metadata -f "{{title}}")"
# 	BODY="$(playerctl $PLAYER metadata -f "{{duration(position)}}")"
# 	# NOTIFY_ID="-r $(notify-send -i $ICON -a "$CONTROL" "$TITLE" "$BODY" $NOTIFY_ID -p -t "$i"000)"
# 	# echo $NOTIFY_ID > /tmp/MEDIA_NOTIFY_ID_$USER

# 	for i in 5 4 3 2 1
# 	do
# 		sleep 1 
# 		if [[ "$(cat /tmp/MEDIA_NOTIFY_ID_$USER)" != $NOTIFY_ID ]]
# 		then
# 		exit 0
# 		fi
# 		TITLE="$(playerctl $PLAYER metadata -f "{{title}}")"
# 		BODY="$(playerctl $PLAYER metadata -f "{{duration(position)}}")"
# 		NOTIFY_ID="-r $(notify-send -i $ICON -a "$CONTROL" "$TITLE" "$BODY" $NOTIFY_ID -p -t "$i"000)"
# 		echo $NOTIFY_ID > /tmp/MEDIA_NOTIFY_ID_$USER
# 	done
# 	rm /tmp/MEDIA_NOTIFY_ID_$USER
# }
# showStatus&
