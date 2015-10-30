'use strict';

class Dash.Views.Landing extends Backbone.View

  template: JST['app/scripts/templates/Landing.html']

  tagName: 'div'

  id: 'main'

  className: ''

  events: 
    'click #login'  : 'login'

  initialize: () ->
    @render()

  render: () ->
    @$el.html @template()

  login : (e)->
    e.preventDefault()
    console.log 'login'
    email = $('#email').val()
    password = $('#password').val()

    Parse.User.logIn email, password,
      success: (user) ->
        # Do stuff after successful login.
        window.location.href = "#dashboard"
        return
      error: (user, error) ->
        # The login failed. Check error to see why.
        alert 'Wrong email/password. Please try again'
        return