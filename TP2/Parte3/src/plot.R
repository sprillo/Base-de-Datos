png(filename = "siete_shards_simple.png", width = 480, height = 480);

simple = read.table("plot2.dat",sep=" ",header = FALSE)
simple$V2 = as.factor(simple$V2)
g = ggplot(data = simple, aes(x = simple$V1, y = simple$V3)) +
    geom_line(aes(group=simple$V2,color=simple$V2)) +
    labs(x = "Numero de iteracion") +
    labs(y = "Porcentaje de datos en shard") +
    labs(title = "Carga de shards a lo largo de las iteraciones, simple") +
  scale_colour_manual(name = "Shard",values=c("blue","black","red","green","grey","purple","yellow"))
g

print(g)
dev.off()