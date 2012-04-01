Martian Robots
==============
The original problem specification is contained in the file MartianRobots.pdf helpfully provided by RedBadger. 

Prerequisites:
[Node.js](http://nodejs.org/) and [npm](http://npmjs.org/) (comes packaged with Node these days) with the following modules:

* coffee-script
* jasmine-node 

You can install these modules by:
	
	sudo npm install -g coffee-script jasmine-node

You can run the excercise's code with:
	coffee mission-to-mars

You can run all the tests with:
    jasmine-node --coffee test

Adding the '--verbose' qualifier will show the test names and test suite titles as well as whether they passed or failed. 

I set up a [watchr](https://github.com/mynyml/watchr) file - robots.watchr - so that the tests are run automatically every time you save a file in your editor, simply run watchr with:
    
    watchr robots.watchr

