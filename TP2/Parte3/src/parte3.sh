#!/bin/bash
shards=$1
puerto_inicial=$2
tipo=$3
config_server_port=$(($puerto_inicial+$shards))
routing_service_port=$(($config_server_port+1))

echo "Creando shards"
for (( i=$puerto_inicial; i<$config_server_port; i++ )) do
	rm -r ./data/localhost$i
	mkdir -p ./data/localhost$i
	mongod --rest --shardsvr --port $i --dbpath data/localhost$i --logpath data/localhost$i/log --fork
done

echo "Creando servidor de configuracion"
mkdir -p ./data/localhost$config_server_port
mongod --rest --port $config_server_port --dbpath data/localhost$config_server_port --logpath data/localhost$config_server_port/log --fork

echo "Creando servicio de routeo"
gnome-terminal -e "bash -c 'mongos --port $routing_service_port --configdb 127.0.0.1:$config_server_port > run_routing_service_log'"

g++ -w -O2 -o "shard_config" "shard_config.cpp"
./shard_config $shards $puerto_inicial $tipo

echo "Cargando datos en Mongo"
mongo 127.0.0.1:$routing_service_port < shard_config.js > output.txt 

echo "Calculando tablas"
g++ -w -O2 -o "scraper" "scraper.cpp"
cat output.txt | ./scraper > data.txt
