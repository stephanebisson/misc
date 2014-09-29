mapReduce = (list, map, reduce) -> 
	bucket = {}
	emit = (key, value) ->
		bucket[key] ?= []
		bucket[key].push value

	map item, emit for item in list
	reduce key, values for key, values of bucket
	
exports.mapReduce = mapReduce if exports?