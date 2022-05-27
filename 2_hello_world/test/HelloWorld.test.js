const HelloWorld = artifacts.require('HelloWorld');

contract('HelloWorld', function() {
	it("should print out hello", function(){
		return HelloWorld.deployed().then(function(instance) {
			instance.setUserName("KM")
			return instance.printMessage.call();
		}).then(function(msg) {
			assert.equal(msg, "Hello KM!", "should print out hello to entered name");
		});
	});
});