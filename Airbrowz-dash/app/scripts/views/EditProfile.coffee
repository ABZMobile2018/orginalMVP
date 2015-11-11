'use strict';

class Dash.Views.EditProfile extends Backbone.View

  template: JST['app/scripts/templates/EditProfile.html']

  tagName: 'div'

  id: ''

  className: ''

  events: {
    'click #save' : 'save'
  }

  initialize: () ->
    @user_model = Parse.User.current()
    @render()

  render: () ->
    output = Mustache.render @template(), { user :  @user_model.toJSON() }
    @$el.html output

  save : (e)->
    e.preventDefault()
    
    company_name = $('#company_name').val().trim()
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
      logo = new (Parse.File)('logo.jpg', file)
      @user_model.set('company_logo', logo)

    @user_model.set('description', description)
    @user_model.set('street_number', street_number)
    @user_model.set('street_name', street_name)
    @user_model.set('postal_code', postal_code)
    @user_model.set('city', city)
    @user_model.set('province', province)
    @user_model.set('company_name', company_name)

    if password
      @user_model.set('password', password)
      @user_model.save(
        success: ()=>
          console.log @user_model.get('email'), password
          Parse.User.logOut()
          Parse.User.logIn @user_model.get('email'), password,
            success: (user) ->
              window.location.href = '#dashboard'
        error: (error) ->
      )
    else 
      @user_model.save(
        success: ()=>
          window.location.href = '#dashboard'
        error:()=>
      )