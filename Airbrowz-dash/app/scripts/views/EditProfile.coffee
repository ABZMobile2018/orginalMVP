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
    Parse.User.current().fetch().then (user)=>
      @user_model = Parse.User.current()
      @render()

  render: () ->
    output = Mustache.render @template(), { user :  @user_model.toJSON() }
    @$el.html output
    $('#phone_number').inputmask("mask", {"mask": "(999) 999 - 9999"})
    @displayHours()

  setHoursOfOperationToModel : ()->
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
    @user_model.set('hours_of_operation', hours_arry)

  displayHours :()->
    hours_arry = @user_model.get('hours_of_operation')
    $('#mon_open').val(hours_arry[0][0])
    $('#mon_close').val(hours_arry[0][1])
    $('#tue_open').val(hours_arry[1][0])
    $('#tue_close').val(hours_arry[1][1])
    $('#wed_open').val(hours_arry[2][0])
    $('#wed_close').val(hours_arry[2][1])
    $('#thu_open').val(hours_arry[3][0])
    $('#thu_close').val(hours_arry[3][1])
    $('#fri_open').val(hours_arry[4][0])
    $('#fri_close').val(hours_arry[4][1])
    $('#sat_open').val(hours_arry[5][0])
    $('#sat_close').val(hours_arry[5][1])
    $('#sun_open').val(hours_arry[6][0])
    $('#sun_close').val(hours_arry[6][1])


  save : (e)->
    e.preventDefault()
    
    company_name   = $('#company_name').val().trim()
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
      logo = new (Parse.File)('logo.jpg', file)
      @user_model.set('company_logo', logo)

    @user_model.set('description', description)
    @user_model.set('street_number', street_number)
    @user_model.set('street_name', street_name)
    @user_model.set('postal_code', postal_code)
    @user_model.set('city', city)
    @user_model.set('province', province)
    @user_model.set('company_name', company_name)
    @user_model.set('facebook_id', facebook_id)
    @user_model.set('phone', phone_number)

    @setHoursOfOperationToModel()

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