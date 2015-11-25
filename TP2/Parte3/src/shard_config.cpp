#include <iostream>
#include <cstdio>
#include <stdlib.h>
#include <assert.h>
using namespace std;

int main ( int argc, char *argv[] ) {
	//assert(argc == 4 && "usage: creator-of-mongo-commands-for-script <number of shards> <initial port> <type: -simple or -hashed>");
	
	int num_shards = atoi(argv[1]);
	int initial_port = atoi(argv[2]);
	string type = argv[3]; // simple or hashed
	
	// el enunciado pide probar con indices simples y hasheados
	assert((type == "-simple" || type == "-hashed") && "<type> must be either -simple or -hashed");
	if (type == "-simple")
		type = "{\"zipcode\": 1}";
	else {
		type = "{\"_id\": \"hashed\"}";
	}

	freopen ("mongo-commands-for-script.js", "w", stdout);

	cout << "use admin" << endl; cout << endl;

	// generalizar esto para mas shards, pasando por parametro el puerto inicial y la cantidad de shards
	for (int i = initial_port; i < initial_port + num_shards; i++) {
		// db.runCommand({addshard:"localhost:10001", name:"shard10001"});
		cout << "db.runCommand({addshard:\"localhost:" << i << "\", name:\"shard" << i << "\"});" << endl;
	}
	cout << endl;
	cout << "use test_sharding" << endl;
	cout << "sh.enableSharding(\"test_sharding\")" << endl; cout << endl;

	// db.people.ensureIndex({"zipcode": 1})
	// sh.shardCollection("test_sharding.people", {"zipcode": 1})
	cout << "db.people.ensureIndex("<< type <<")" << endl; // aca hay que poner opcion hashed
	cout << "sh.shardCollection(\"test_sharding.people\", "<< type <<")" << endl; cout << endl;
	cout << "load(\"ej3ingresoDatos.js\")" << endl; cout << endl;

	// borro todo lo escrito para poder reproducir el experimento en iguales condiciones la proxima vez
	cout << "use admin" << endl;
	for (int i = initial_port; i < initial_port + num_shards; i++) {
		// db.runCommand( { removeShard: "shard10001" } )
		cout << "db.runCommand({removeShard: \"shard" << i << "\"})" << endl;
	}
	cout << endl;

	cout << "use test_sharding" << endl;
	cout << "db.dropDatabase()" << endl;
	return 0;
}
