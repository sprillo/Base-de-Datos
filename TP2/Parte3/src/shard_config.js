use admin

db.runCommand({addshard:"localhost:43234", name:"shard43234"});
db.runCommand({addshard:"localhost:43235", name:"shard43235"});
db.runCommand({addshard:"localhost:43236", name:"shard43236"});
db.runCommand({addshard:"localhost:43237", name:"shard43237"});
db.runCommand({addshard:"localhost:43238", name:"shard43238"});
db.runCommand({addshard:"localhost:43239", name:"shard43239"});
db.runCommand({addshard:"localhost:43240", name:"shard43240"});

use test_sharding
sh.enableSharding("test_sharding")

db.people.ensureIndex({"_id": "hashed"})
sh.shardCollection("test_sharding.people", {"_id": "hashed"})

load("crear_inserts.js")

use admin
db.runCommand({removeShard: "shard43234"})
db.runCommand({removeShard: "shard43235"})
db.runCommand({removeShard: "shard43236"})
db.runCommand({removeShard: "shard43237"})
db.runCommand({removeShard: "shard43238"})
db.runCommand({removeShard: "shard43239"})
db.runCommand({removeShard: "shard43240"})

use test_sharding
db.dropDatabase()
