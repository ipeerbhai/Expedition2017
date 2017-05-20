require('express')().use(require('express').static(__dirname + '/rin'))
.listen(3000, () => {
  console.log('client up on 3000');
});
