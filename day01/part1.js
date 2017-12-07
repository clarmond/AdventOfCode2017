#!/usr/local/bin/node

'use strict';

var fs = require('fs');

var testCases = [
	{
		"input": "1122",
		"result": 3
	},
	{
		"input": "1111",
		"result": 4
	},
	{
		"input": "1234",
		"result": 0
	},
	{
		"input": "91212129",
		"result": 9
	}
];

console.log("Running test cases");
for (var i = 0; i < testCases.length; i++) {
	var data = testCases[i];
	var expected = data.result;
	var actual = getTotal(data.input);
	var caseNumber = i + 1;
	console.assert((actual == expected), "Test Case " + caseNumber.toString());
}
console.log("Test cases passed");

fs.readFile('input.txt', 'utf8', function(err, data) {
	if (err) {
		console.error(err);
	}
	var inputString = data.replace(/[\n\r]/, "");
	console.log("Puzzle answer: " + getTotal(inputString));
});


function getTotal(inputString) {
	var total = 0;
	for (var i = 0; i < inputString.length; i++) {
		var currChar = parseInt(inputString.substr(i, 1));
		var nextChar = parseInt(inputString.substr(i+1, 1));
		if (i === inputString.length - 1) {
			nextChar = parseInt(inputString.substr(0, 1));
		}
		if (currChar == nextChar) {
			total += currChar;
		}
	}
	return total;
}
