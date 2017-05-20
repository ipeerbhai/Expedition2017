module.exports = function(app) {
  app.controller('dashBoardController', ['$http', '$location', function($http, $location) {
    this.getAll = function() {
      $http({
        method: 'GET',
        url: 'api/',
      })
      .then((res) => {
        this.all = res.data;
      }, (response) => {
        console.log(response);
      });
    }

    this.post = function() {
      $http: 'POST',
      url: 'api/'
    }
  }]);
};
