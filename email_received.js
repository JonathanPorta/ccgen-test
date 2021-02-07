"use strict";

// email_received::handle(event, context, callback)
exports.handle = function (event, context, callback) {
  let name = event.name === undefined ? "Unknown" : event.name;
  callback(null, { Hello: name });
};
