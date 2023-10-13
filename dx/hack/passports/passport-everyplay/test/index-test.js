var vows = require('vows');
var assert = require('assert');
var util = require('util');
var everyplay = require('passport-everyplay');


vows.describe('passport-everyplay').addBatch({
  
  'module': {
    'should report a version': function (x) {
      assert.isString(everyplay.version);
    },
  },
  
}).export(module);
