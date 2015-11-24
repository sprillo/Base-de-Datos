#!/bin/bash
	num_shards=$1
	initial_port=$2
	type=$3
	archivo_salida=$4
	config_server_port=$(($initial_port+$num_shards))
	routing_service_port=$(($config_server_port+1))
	
	echo "Creating shards"
	for (( i=$initial_port; i<$config_server_port; i++ )) do
		rm -r ./data/localhost$i
		mkdir -p ./data/localhost$i
		mongod --rest --shardsvr --port $i --dbpath data/localhost$i --logpath data/localhost$i/log --fork
	done
	
	echo "Creating config server"
	mkdir -p ./data/localhost$config_server_port
	mongod --rest --port $config_server_port --dbpath data/localhost$config_server_port --logpath data/localhost$config_server_port/log --fork
	
	echo "Creating routing service"
	gnome-terminal -e "bash -c 'mongos --port $routing_service_port --configdb 127.0.0.1:$config_server_port > run_routing_service_log'"
	
	g++ -w -O2 -o "creator-of-mongo-commands-for-script" "creator-of-mongo-commands-for-script.cpp"
	./creator-of-mongo-commands-for-script $num_shards $initial_port $type
	
	echo "Opening mongo and writing results to file"
	# esto a veces es problematico y conviene correrlo por separado (comentar esto y lo que sigue y correrlo independientemente)
	mongo 127.0.0.1:$routing_service_port < mongo-commands-for-script.js > output.txt 
	
	echo "Parsing mongoDB output"
	g++ -w -O2 -o "parser" "parser.cpp"
	cat output.txt | ./parser > plot.dat
	
	echo "Plotting data"
	gnuplot -e "num_shards = $num_shards" plotting-shard-distribution.plt > $archivo_salida
