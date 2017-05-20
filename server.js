// This is our API and front end app for the hackathon.
// let's start by getting epxress up and pulling in our Application Programming Interface.

const express = require('express');
const app = express();
var API = require('./API');

app.use(express.static(__dirname + '/build'));

// setup to listen and begin sering content.
app.set('port', process.env.PORT || 3000);

app.listen(app.get('port'), function () {
    console.log('Express started on http://localhost:' + app.get('port') + '; Press CTRL-C to terminate.');
});


//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
// API Routes
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
app.post('/v1/SummarizeText', function (req, res) {
    API.SummarizeText(req, res);
});


