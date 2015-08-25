app = angular.module('Tasks', ['ngResource', 'xeditable'])

app.factory 'Task', ['$resource', ($resource) ->
  $resource('/tasks/:id', {id: '@id'}, {update: {method: 'PUT'}})
]

@TasksCtrl = ['$scope', '$q', 'Task', ($scope, $q, Task) ->
  $scope.tasks = Task.query
    status: 'active'

  $scope.completed_tasks = Task.query
    status: 'completed'

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
    d = $q.defer()
    Task.update( id: task.id, {task: attributes},
      () ->
        d.resolve()
      (response) ->
        d.resolve response.data.errors[field][0]
    )
    return d.promise

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

  $scope.sort = (field) ->
    $('.sort .glyphicon').removeClass('active')
    arrow = $("#" + field)
    arrow.addClass('active')
    if arrow.hasClass('glyphicon-arrow-down')
      arrow.removeClass('glyphicon-arrow-down')
      arrow.addClass('glyphicon-arrow-up')
      direction = 'desc'
    else
      arrow.addClass('glyphicon-arrow-down')
      arrow.removeClass('glyphicon-arrow-up')
      direction = 'asc'

    $scope.tasks = Task.query
      status: 'active', order_by: field, direction: direction

   $scope.attachDatepicker = (task) ->
    $('ul.tasks form input').datepicker
      dateFormat: 'yy-mm-dd'
      ,onSelect: (date, instance) ->
        task.due_date = date
        Task.update(id: task.id, {due_date: date})
        $('body').click()
]
