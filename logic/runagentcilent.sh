#!/bin/bash
server = "127.0.0.1:20000"
port="30000"
d=0
player=1
timelimit=100
GETOPT_ARGS=`getopt -o d: -al server:,port:,playercount:,timelimit -- "$@"`
eval set -- "GETOPT_ARGS"
while [-n "$1"]
do
	case "$1" in
		--server) server=$2; shift 2;;
		--port) port=$2; shift 2;;
		-d) d=$2; shift 2;;
		--playercount) player=$2; shift 2;;
		--timelimit) timelimit=$2; shift 2;;
		--) break;;
	esac
done

server_index='expr index $server ":" '
server_index=server_index-1
server_agent=${server:1:$server_index}

if [player==1];then
	echo "1 player"
	/usr/local/AI1 $server_agent $port >> debug1.txt 2>&1
else if [player==2];then
	echo "2 player"
	/usr/local/AI1 $server_agent $port >> debug1.txt 2>&1
	/usr/local/AI2 $server_agent $port >> debug2.txt 2>&1
fi
	
dotnet /usr/local/app/Communication.Agent.dll --server $server --port $port -d $d --playercount $player --timelimit $timelimit
