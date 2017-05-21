// This is our API for the hackathon.  the design patterns we use are:
// PutX ( where X is from a client or service to local storage)
// GetX ( Where X is from local storage to either a client or service )
// GetAndDeleteX ( We get X, then delete the store for it.)

const os = require('os');
const fs = require('fs');
const path = require('path');
var jsonlines = require('jsonlines');
var parser = jsonlines.parse();
const execSync = require('child_process').execSync;
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
// Private functions
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------------
function SaveJSONFile(File, JSONData, ShouldAppend = true) {
    if (fs.existsSync(File)) {
        if (!ShouldAppend) {
            fs.unlinkSync(File);
        }
    }

    fs.appendFile(File, JSON.stringify(JSONData), function (err) {
        if (err)
            console.log(err);
    });
    fs.appendFile(File, '\n', function (err) {
        if (err)
            console.log(err);
    });
}

//---------------------------------------------------------------------------------------------------------------------------
// Authorize checks that the API call is properly allowed to use this API.
function Authorize(req, res) {
    var AuthorizationHeader = req.header("Authorization");
    var _clientID = req.header("X-Client-ID");
    var AllowedToUseAP = false;

    if (AuthorizationHeader === "ExpiditionHack2017") {
        AllowedToUseAP = true;
    }
    else {
        // we are not authorized.  Send a forbidden code (403)
        res.status = 403;
        res.send(); // this will end the session, and 
    }

    // Check authorized client.  If not, close out the tunnel.
    var Authorization = {
        IsAuthroized: AllowedToUseAP,
        ClientID: _clientID
    };

    return (Authorization);
}
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
// Exported functions
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------------
// Exported Function:
//  Input a string to this function, get back an automatic summarization.
var SummarizeText = function (req, res) {
    var AuthToken = Authorize(req, res);
    if (!AuthToken.IsAuthroized) {
        return;
    }

    var _Message = req.body.Message;

    // Run Gensim and get a result
    // var GensimSummary = RunGenSim(_Message)

    // Return the string to the caller.
    res.setHeader('content-type', contentType);
    // res.write(GensimSumary);
    res.status = 200;
    res.send();
};

//---------------------------------------------------------------------------------------------------------------------------
var Search = function (req, res) {
    var outFile = os.tmpdir() + path.sep + "search.txt";
    var SearchEXE = "C:\\Github\\Expedition2017\\SmartScoreSystem\\SmartScoreSystem\\bin\\Debug\\SmartScoreSystem.exe";
    var _keywords = req.body.keywords;
    var _articleCount = req.body.numOfArt;

    // build the JSON
    var InterChange = {
        keywords: _keywords,
        articleCount: _articleCount
    };

    // save it
    SaveJSONFile(outFile, InterChange, false);

    // Exec the C# console program that actually reads and searches.
    var output = execSync(SearchEXE);
    res.render('home', {
        MAINCONTENT: output
    });
};
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
// Exports
//---------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------
module.exports.SummarizeText = SummarizeText;
module.exports.Search = Search;