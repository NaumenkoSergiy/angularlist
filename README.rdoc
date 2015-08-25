== README

This is ToDo list build with angularjs and API on the back-end using RoR.

[Link](http://angularlist-naumenko.herokuapp.com/) to Heroku app.

= API

1 authorize a client

  curl -X POST --data "email=[email]&password=[password]" http://angularlist-naumenko.herokuapp.com/users/sign_in

  if success it returns an access token
  token is valid for two hours then you need to go thru authorization again and get new access token

2 get the list of tasks

  curl -X GET --data "token=[access token]" http://angularlist-naumenko.herokuapp.com/tasks

3 create new task

  curl -X POST --data "token=[acess token]&task[title]=newtask" http://angularlist-naumenko.herokuapp.com/tasks

4 complete task

  curl -X PUT --data "token=[access token]&task[completed]=true" http://angularlist-naumenko.herokuapp.com/tasks/[task id]

5 update existing task

  the same way as complete task

6 delete task

  curl -X DELETE --data "token=[access token]" http://angularlist-naumenko.herokuapp.com/tasks/[task id]

7 sort tasks

  curl -X GET --data "token=[access token]&order_by=priority&direction=asc" http://angularlist-naumenko.herokuapp.com/tasks

= Tests

  using Rspec

  rake db:test:clone
  rake
