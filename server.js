const express = require('express');
const app = express();

app.use(express.static(__dirname + '/build')
  .listen(3000, () => console.log('sever up on 3000'))
