#include <iostream>
#include <cstdio>
#include <stdlib.h>
#include <assert.h>
using namespace std;

int main ( int argc, char *argv[] ) {
	
	int shards = atoi(argv[1]);
	int puerto_inicial = atoi(argv[2]);
	string tipo = argv[3];
	
	assert(tipo == "simple" || tipo == "hashed");
	if (tipo == "simple")
		tipo = "{\"zipcode\": 1}";
	else {
		tipo = "{\"_id\": \"hashed\"}";
	}

	freopen ("shard_config.js", "w", stdout);

	cout << "use admin" << endl; cout << endl;
	
	for (int i = puerto_inicial; i < puerto_inicial + shards; i++) {
		cout << "db.runCommand({addshard:\"localhost:" << i << "\", name:\"shard" << i << "\"});" << endl;
	}
	cout << endl;
	cout << "use test_sharding" << endl;
	cout << "sh.enableSharding(\"test_sharding\")" << endl; cout << endl;

	cout << "db.people.ensureIndex("<< tipo <<")" << endl; // aca hay que poner opcion hashed
	cout << "sh.shardCollection(\"test_sharding.people\", "<< tipo <<")" << endl; cout << endl;
	cout << "load(\"crear_inserts.js\")" << endl; cout << endl;

	cout << "use admin" << endl;
	for (int i = puerto_inicial; i < puerto_inicial + shards; i++) {
		cout << "db.runCommand({removeShard: \"shard" << i << "\"})" << endl;
	}
	cout << endl;

	cout << "use test_sharding" << endl;
	cout << "db.dropDatabase()" << endl;
	return 0;
}
