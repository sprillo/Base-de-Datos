use admin

db.runCommand({addshard:"localhost:11111", name:"shard11111"});
db.runCommand({addshard:"localhost:11112", name:"shard11112"});
db.runCommand({addshard:"localhost:11113", name:"shard11113"});
db.runCommand({addshard:"localhost:11114", name:"shard11114"});
db.runCommand({addshard:"localhost:11115", name:"shard11115"});
db.runCommand({addshard:"localhost:11116", name:"shard11116"});
db.runCommand({addshard:"localhost:11117", name:"shard11117"});

use test_sharding
sh.enableSharding("test_sharding")

db.people.ensureIndex({"zipcode": 1})
sh.shardCollection("test_sharding.people", {"zipcode": 1})

load("ej3ingresoDatos.js")

use admin
db.runCommand({removeShard: "shard11111"})
db.runCommand({removeShard: "shard11112"})
db.runCommand({removeShard: "shard11113"})
db.runCommand({removeShard: "shard11114"})
db.runCommand({removeShard: "shard11115"})
db.runCommand({removeShard: "shard11116"})
db.runCommand({removeShard: "shard11117"})

use test_sharding
db.dropDatabase()
