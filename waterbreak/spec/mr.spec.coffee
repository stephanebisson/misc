mapReduce = require('../app/mr').mapReduce

describe 'mapReduce', ->

	it 'should just work', ->
		list = [{name: 'a'},{name: 'a'},{name: 'b'}]
		map = (item, emit) -> 
			emit item.name, 1
		reduce = (key, items) ->
			result = 
				name: key
				count: items.length
			result

		result = mapReduce(list, map, reduce)
		expected = [{name: 'a', count: 2}, {name: 'b', count: 1}]

		expect(result).toEqual(expected)

