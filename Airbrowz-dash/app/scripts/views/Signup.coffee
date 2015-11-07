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
    Parse.User.logOut()
    @$el.html @template()

  signup :(e)->
    e.preventDefault()
    company_name = $('#company_name').val().trim()
    email = $('#email').val().trim()
    password = $('#password').val().trim()
    description = $('#description').val().trim()
    street_number = $('#street_number').val().trim()
    street_name = $('#street_name').val().trim()
    postal_code = $('#postal_code').val().trim()
    city = $('#city').val().trim()
    province = $('#province').val().trim()

    fileUploadControl = $('#company_logo')[0]
    if fileUploadControl.files.length > 0
      file = fileUploadControl.files[0]
      name = 'logo.jpg'
      logo = new (Parse.File)(name, file)

    unless (email and password and description and street_number and street_name and postal_code and city and province and logo and company_name)
      return alert 'Please fill in all the textboxes'

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
    user.set 'company_logo', logo
    user.set 'company_name', company_name

    user.signUp null,
      success: (user) ->
        
        window.location.href = '#dashboard'

        return
      error: (user, error) ->
        # Show the error message somewhere and let the user try again.
        alert 'Error: ' + error.code + ' ' + error.message
        return