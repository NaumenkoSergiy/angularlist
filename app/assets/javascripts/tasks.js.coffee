app = angular.module('Tasks', ['ngResource', 'xeditable']).run (editableOptions) ->
  editableOptions.theme = 'default'

app.factory 'Task', ['$resource', ($resource) ->
  $resource('/tasks/:id', {id: '@id'}, {update: {method: 'PUT'}})
]

@TasksCtrl = ['$scope', 'Task', ($scope, Task) ->
  $scope.tasks = Task.query
    status: 'active'
  , ->

  $scope.completed_tasks = Task.query
    status: 'completed'
  , ->

  $scope.add = ->
    task = Task.save($scope.newTask)
    $scope.tasks.push(task)
    $scope.newTask = {}

  $scope.delete = (task) ->
    if confirm('Are you sure')
      idx = $scope.tasks.indexOf(task)
      Task.delete
        id: task.id
      , (success) ->
        $scope.tasks.splice idx, 1
        return

  $scope.update = (task, data, field) ->
    attributes = {}
    attributes[field] = data
    Task.update(id: task.id, {task: attributes})

  $scope.complete = (task) ->
    Task.update
      id: task.id, task: {completed: true}
    , ->
      idx = $scope.tasks.indexOf(task)
      $scope.tasks.splice idx, 1
      $scope.completed_tasks.push(task)

  $scope.restore = (task) ->
    Task.update
      id: task.id, task: {completed: false}
    , ->
      idx = $scope.completed_tasks.indexOf(task)
      $scope.completed_tasks.splice idx, 1
      $scope.tasks.push(task)
]
