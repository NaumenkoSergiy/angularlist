app = angular.module('Tasks', ['ngResource'])

app.factory 'Task', ['$resource', ($resource) ->
  $resource('/tasks/:id', {id: '@id'}, {update: {method: 'PUT'}})
]

@TasksCtrl = ['$scope', 'Task', ($scope, Task) ->
  $scope.tasks = Task.query ->

  $scope.addTask = ->
    task = Task.save($scope.newTask)
    $scope.tasks.push(task)
    $scope.newTask = {}
]
