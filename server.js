// This is our API and front end app for the hackathon.
// let's start by getting epxress up and pulling in our Application Programming Interface.

const express = require('express');
const app = express();
var API = require('./API');

app.use(express.static(__dirname + '/build')
  .listen(3000, () => console.log('sever up on 3000')));

//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
// API Routes
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
app.post('/v1/SummarizeText', function (req, res) {
    API.SummarizeText(req, res);
});


