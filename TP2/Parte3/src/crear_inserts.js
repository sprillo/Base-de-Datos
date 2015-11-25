function crear_inserts(tamanio_tanda, tandas){
	for (var j = 0; j < tandas; j += 1) {
		for (var i = 0; i < tamanio_tanda; i++) {
			var toInsert={};				
			toInsert.name = "FakeNameFakeNameFakeNameFakeNameFakeNameFakeNameFakeName";
			toInsert.password = "FakePasswordFakePasswordFakePasswordFakePasswordFakePassword";
			toInsert.zipcode = Math.random() % 1000000;
			toInsert.gender = "M";
			toInsert.age = 50;
			toInsert.creationDate = new Date(2015, 10, 15);	
			db.people.insert(toInsert);
		}
		sh.status(true);
		db.people.getShardDistribution();
	}
}

crear_inserts(32000, 25);
