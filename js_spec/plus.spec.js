var plus = require('../js_code/plus');

describe("my reduce function", function(){

	it ("should not crash with null", function(){
		expect(plus(1,2)).toEqual(3);
	})

})