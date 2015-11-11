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
    $('#phone_number').inputmask("mask", {"mask": "(999) 999 - 9999"})

  setHoursOfOperationToModel : (user)->
    mon_open  = $('#mon_open').val()
    mon_close = $('#mon_close').val()
    tue_open  = $('#tue_open').val()
    tue_close = $('#tue_close').val()
    wed_open  = $('#wed_open').val()
    wed_close = $('#wed_close').val()
    thu_open  = $('#thu_open').val()
    thu_close = $('#thu_close').val()
    fri_open  = $('#fri_open').val()
    fri_close = $('#fri_close').val()
    sat_open  = $('#sat_open').val()
    sat_close = $('#sat_close').val()
    sun_open  = $('#sun_open').val()
    sun_close = $('#sun_close').val()

    hours_arry = [
      [mon_open, mon_close]
      [tue_open, tue_close]
      [wed_open, wed_close]
      [thu_open, thu_close]
      [fri_open, fri_close]
      [sat_open, sat_close]
      [sun_open, sun_close]
    ]

    for hours, i in hours_arry
      if hours[0] is "" or hours[1] is ""
        hours_arry[i] = []
    user.set('hours_of_operation', hours_arry)

  signup :(e)->
    e.preventDefault()
    company_name   = $('#company_name').val().trim()
    email          = $('#email').val().trim()
    password       = $('#password').val().trim()
    description    = $('#description').val().trim()
    street_number  = $('#street_number').val().trim()
    street_name    = $('#street_name').val().trim()
    postal_code    = $('#postal_code').val().trim()
    city           = $('#city').val().trim()
    province       = $('#province').val().trim()
    facebook_id    = $('#facebook').val().trim()
    phone_number   = $('#phone_number').val().trim()
    if facebook_id.length > 0 
      facebook_id = facebook_id.replace('://', '').split('/')[1]

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
    user.set 'phone', phone_number
    user.set 'facebook_id', facebook_id

    @setHoursOfOperationToModel(user)

    user.signUp null,
      success: (user) ->
        
        window.location.href = '#dashboard'

        return
      error: (user, error) ->
        # Show the error message somewhere and let the user try again.
        alert 'Error: ' + error.code + ' ' + error.message
        return