#include <iostream>
#include <cstdio>
#include <vector> 
#include <map>
#include <set>
using namespace std;

/*
MongoDB shell version: 2.0.4
connecting to: localhost:10003/test
switched to db admin
{
	"ok" : 0,
	"errmsg" : "can't add shard localhost:10000 because a local database 'test_sharding' exists in another shard10000:localhost:10000"
}
{
	"ok" : 0,
	"errmsg" : "can't add shard localhost:10001 because a local database 'test_sharding' exists in another shard10000:localhost:10000"
}
switched to db test_sharding
command failed: { "ok" : 0, "errmsg" : "already enabled" }
already enabled
command failed: { "ok" : 0, "errmsg" : "already sharded" }
already sharded
Shard shard10000 at localhost:10000
 data : 193.93Mb docs : 1452532 chunks : 11
 estimated data per chunk : 17.62Mb
 estimated docs per chunk : 132048
Shard shard10001 at localhost:10001
 data : 281.63Mb docs : 2109413 chunks : 11
 estimated data per chunk : 25.6Mb
 estimated docs per chunk : 191764
Totals
 data : 475.56Mb docs : 3561945 chunks : 22
 Shard shard10000 contains 40.77% data, 40.77% docs in cluster, avg obj size on shard : 139b
 Shard shard10001 contains 59.22% data, 59.22% docs in cluster, avg obj size on shard : 140b
Shard shard10000 at localhost:10000
 data : 193.93Mb docs : 1452542 chunks : 11
 estimated data per chunk : 17.62Mb
 estimated docs per chunk : 132049
Shard shard10001 at localhost:10001
 data : 281.63Mb docs : 2109413 chunks : 11
 estimated data per chunk : 25.6Mb
 estimated docs per chunk : 191764
Totals
 data : 475.57Mb docs : 3561955 chunks : 22
 Shard shard10000 contains 40.77% data, 40.77% docs in cluster, avg obj size on shard : 139b
 Shard shard10001 contains 59.22% data, 59.22% docs in cluster, avg obj size on shard : 140b
 (...)
*/
 
double convertToMb (double number, string unit) {
	if (unit == "MiB")
		return number;
	if (unit == "KiB")
		return number / 1000.0;
	if (unit == "B")
		return number / 1000000.0;
	if (unit == "GiB")
		return number * 1000.0;
		
	return -1.0;
}


int main () {
	int NMAX = 20000;
	double amountData[NMAX];
	int numberDocs[NMAX], numberChunks[NMAX];
	string amountDataUnit[NMAX];
	
	vector<map<string, double> > percentageData(NMAX, map<string, double>());
	vector<map<string, double> > percentageDocs(NMAX, map<string, double>());
	vector<map<string, int> > avgSize(NMAX, map<string, int>());
	vector<map<string, string> > avgSizeUnit(NMAX, map<string, string>());
	
	set <string> namesShards;
	// solo leo los totales
	int i = 0;
	string totals;
	while (cin >> totals) {
		if (totals != "Totals")
			continue;
		
		string data, colon, docs, chunks, shard, nameShard, contains, in, cluster, avg, obj, size, on;
		cin >> data >> colon >> amountData[i] >> amountDataUnit[i] >> docs >> colon >> numberDocs[i] >> chunks >> colon >> numberChunks[i];
		amountData[i] = convertToMb(amountData[i], amountDataUnit[i]);
		
		while ((cin >> shard >> nameShard >> contains) && contains == "contains") {
			namesShards.insert(nameShard);
			cin >> percentageData[i][nameShard] >> colon >> data;
			cin >> percentageDocs[i][nameShard] >> colon >> docs >> in >> cluster;
			cin >> avg >> obj >> size >> on >> shard >> colon >> avgSize[i][nameShard] >> avgSizeUnit[i][nameShard];
		}
		i++;
	}
	
	// imprimo en el formato de gnuplot
	for (std::set<string>::iterator it=namesShards.begin(); it!=namesShards.end(); ++it) {
		cout << *it << endl;
		for (int j = 0; j < i; j++) {
			printf("%.2f\t %.2f\n", amountData[j], percentageData[j][*it]);
		}
		cout << endl;
		cout << endl;
	}
}
