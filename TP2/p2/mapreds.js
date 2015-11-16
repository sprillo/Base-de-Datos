var map1 = function(){
	emit(this["FechaDisposicion"],1)
}

var reduce1 = function(key,values){
	return Array.sum(values)
}

var map2 = function(){
	emit(this["Tipo"],1)
}

var reduce2 = function(key,values){
	return Array.sum(values)
}

var map3 = function(){
	emit(this["FechaBOJA"],1)
}

var reduce3 = function(key,values){
	return Array.sum(values)
}

var map4 = function(){
	emit(this["Tipo"],this["PaginaFinal"] - this["PaginaInicial"] + 1)
}

var reduce4 = function(key,values){
	res = values[0]
	for (var i=1; i < values.length; i++){
		if(res < values[i]){
			res = values[i]
		}
	}
	return res
}
