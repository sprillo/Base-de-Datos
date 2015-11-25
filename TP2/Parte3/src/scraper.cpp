#include <iostream>
#include <cstdio>
#include <vector> 
#include <map>
#include <set>
using namespace std;
 
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
	
	int a = 0;
	for (std::set<string>::iterator it=namesShards.begin(); it!=namesShards.end(); ++it) {
		a++;
		for (int j = 0; j < i; j++) {
			printf("%i\t %i\t %.2f\n", j + 1, a, percentageData[j][*it]);
		}
	}
}
