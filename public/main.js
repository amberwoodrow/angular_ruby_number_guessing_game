var app = angular.module('myApp', []);

app.controller('appController', function($scope, $http){
  $scope.takeGuess = function(){
    console.log($scope.guess);
    $http.post('/guess', { guess: $scope.guess }).then(function(response){
      $scope.result = response.data.result;
    });
  };
});
