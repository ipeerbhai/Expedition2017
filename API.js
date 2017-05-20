// This is our API for the hackathon.  the design patterns we use are:
// PutX ( where X is from a client or service to local storage)
// GetX ( Where X is from local storage to either a client or service )
// GetAndDeleteX ( We get X, then delete the store for it.)

const os = require('os');
const fs = require('fs');
const path = require('path');
var jsonlines = require('jsonlines');
var parser = jsonlines.parse();

//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
// Exports
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
