var app = angular.module('myApp', []);

app.controller('appController', function($scope, $http){
  $scope.turns = 0;

  $scope.takeGuess = function(){
    $http.post('/guess', { guess: $scope.guess }).then(function(response){
      $scope.result = response.data.result;
      $scope.turns = response.data.turns;
    });
    $scope.guess = "";
  };
});
