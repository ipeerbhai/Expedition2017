// This is our API and front end app for the hackathon.
// let's start by getting epxress up and pulling in our Application Programming Interface.

var fs = require('fs'),
  http = require('http'),
  https = require('https'),
  express = require('express'),
  path = require('path'),
  favicon = require('serve-favicon');
var API = require('./API');

// init express and setup some parsers and caches.
var app = express();
app.use(express.json());       // to support JSON-encoded bodies
app.use(express.urlencoded()); // to support URL-encoded bodies
app.use(favicon(__dirname + '/public/favicon.ico'));
app.use(function (req, res, next) {
  if (req.is('text/*')) {
    req.text = '';
    req.setEncoding('utf8');
    req.on('data', function (chunk) { req.text += chunk });
    req.on('end', next);
  } else {
    next();
  }
});

// setup handlebars and make a default view.
var handlebars = require('express3-handlebars').create({ defaultLayout: 'main' });
app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.use(express.static(path.join(__dirname, 'public')));

// setup to listen and begin sering content.
app.set('port', process.env.PORT || 3000);

app.listen(app.get('port'), function () {
  console.log('Express started on http://localhost:' + app.get('port') + '; Press CTRL-C to terminate.');
});

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
// API Routes
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
app.post('/v1/SummarizeText', function (req, res) {
  API.SummarizeText(req, res);
});


//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
// HandleBars routes
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------

// template a landing markup



app.get('/', function (req, res) {


  res.render('home', {
  });

});
