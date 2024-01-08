local newdecoder = require 'json.lunajson.decoder'
local newencoder = require 'json.lunajson.encoder'
local sax = require 'json.lunajson.sax'
-- If you need multiple contexts of decoder and/or encoder,
-- you can require lunajson.decoder and/or lunajson.encoder directly.
return {
	decode = newdecoder(),
	encode = newencoder(),
	newparser = sax.newparser,
	newfileparser = sax.newfileparser,
}
