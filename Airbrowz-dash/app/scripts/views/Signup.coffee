'use strict';

class Dash.Views.Signup extends Backbone.View

  template: JST['app/scripts/templates/Signup.html']

  tagName: 'div'

  id: 'main'

  className: ''

  events: 
    'click #register' : 'signup'

  initialize: () ->
    @render()

  render: () ->
    @$el.html @template()

  signup :(e)->
    e.preventDefault()
    email = $('#email').val()
    password = $('#password').val()
    description = $('#description').val()
    street_number = $('#street_number').val()
    street_name = $('#street_name').val()
    postal_code = $('#postal_code').val()
    city = $('#city').val()
    province = $('#province').val()

    user = new (Parse.User)
    user.set 'username', email
    user.set 'password', password
    user.set 'email', email
    user.set 'description', description
    user.set 'street_number', street_number
    user.set 'street_name', street_name
    user.set 'postal_code', postal_code
    user.set 'city', city
    user.set 'province', province


    user.signUp null,
      success: (user) ->
        
        window.location.href = '#dashboard'

        return
      error: (user, error) ->
        # Show the error message somewhere and let the user try again.
        alert 'Error: ' + error.code + ' ' + error.message
        return