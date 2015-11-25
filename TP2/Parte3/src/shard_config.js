use admin

db.runCommand({addshard:"localhost:21111", name:"shard21111"});
db.runCommand({addshard:"localhost:21112", name:"shard21112"});
db.runCommand({addshard:"localhost:21113", name:"shard21113"});
db.runCommand({addshard:"localhost:21114", name:"shard21114"});
db.runCommand({addshard:"localhost:21115", name:"shard21115"});
db.runCommand({addshard:"localhost:21116", name:"shard21116"});
db.runCommand({addshard:"localhost:21117", name:"shard21117"});

use test_sharding
sh.enableSharding("test_sharding")

db.people.ensureIndex({"zipcode": 1})
sh.shardCollection("test_sharding.people", {"zipcode": 1})

load("ej3ingresoDatos.js")

use admin
db.runCommand({removeShard: "shard21111"})
db.runCommand({removeShard: "shard21112"})
db.runCommand({removeShard: "shard21113"})
db.runCommand({removeShard: "shard21114"})
db.runCommand({removeShard: "shard21115"})
db.runCommand({removeShard: "shard21116"})
db.runCommand({removeShard: "shard21117"})

use test_sharding
db.dropDatabase()
