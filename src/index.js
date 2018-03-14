'use strict';
const Alexa = require('alexa-sdk');

exports.handler = function(event, context, callback) {
  var alexa = Alexa.handler(event, context);
  alexa.registerHandlers(handlers);
  alexa.execute();
};

const mainFunction = function() {
  this.response.speak('Hello, world!');
  this.emit(':responseReady');
};

const handlers = {
  'LaunchRequest': mainFunction
};
