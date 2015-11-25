
function randomZipCode (beginningOfInterval, widthOfInterval){
	return Math.floor(beginningOfInterval + (Math.random() * widthOfInterval));
}

function populatePeople (amountRegisters, repetitions, maxZipCode){
	for (var j = 0; j < repetitions; j += 1) {
		for (var i = 0; i < amountRegisters; i++) {
			var toInsert={};				
			toInsert.name = "FakeNameFakeNameFakeNameFakeNameFakeNameFakeNameFakeName";
			toInsert.password = "FakePasswordFakePasswordFakePasswordFakePasswordFakePassword";
			toInsert.zipcode = randomZipCode(0, maxZipCode - 1);
			toInsert.gender = "Female";
			toInsert.age = 15;
			toInsert.creationDate = new Date(2015, 10, 15);	
			db.people.insert(toInsert);
		}
		sh.status(true);
		db.people.getShardDistribution();
	}
}

// 25 intervalos pues 25 * 32000 = 800000
// pongan hasta 50 intervalos
populatePeople(32000, 25, 1000000);
