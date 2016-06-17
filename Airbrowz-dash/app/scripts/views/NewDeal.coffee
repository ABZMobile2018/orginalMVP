'use strict';

class Dash.Views.NewDeal extends Backbone.View

  template: JST['app/scripts/templates/NewDeal.html']

  tagName: 'div'

  id: 'main'

  events: {
    'click #create'     : 'create'
    'change #dealImage' : 'fileSelected'
  }

  initialize: () ->
    @render()

  render: () ->
    @$el.html @template()
    $('#date').datetimepicker(
      inline     : true
      sideBySide : true
      useCurrent : true
    )
    $('#date').data('DateTimePicker').minDate(new Date())
    now = (new Date())
    now.setHours(now.getHours()+5);
    $('#date').data('DateTimePicker').date(now)

  generateUUID : ()->
    s4 = ->
      Math.floor((1 + Math.random()) * 0x10000).toString(16).substring 1
    s4() + s4() + s4() + s4() + s4() + s4() + s4() + s4()

  getYoutubeIdFromURI: (uri) ->
    match = RegExp('[?&]v=([^&]*)').exec(uri)
    match and decodeURIComponent(match[1].replace(/\+/g, ' '))

  fileSelected : (e)->
    fileUploadControl = $('#dealImage')[0]
    if fileUploadControl.files.length > 0
      $('#spinner').removeClass('hidden')
      file = fileUploadControl.files[0]
      name = @generateUUID()
      image = new Parse.File(name, file)
      TempImages = Parse.Object.extend("TempImages")
      tempImage = new TempImages()
      tempImage.set 'file', image
      tempImage.save(
        success: (obj)->
          uri = obj.get('file')._url
          $('#thumbnail').attr('src', uri)
          $('#thumbnail').removeClass('hidden')
          $('#spinner').addClass('hidden')
      )

  create : (e)->
    e.preventDefault()
    $("#create").html('submitting...').prop('disabled', true)

    heading = $('#heading').val()
    fileUploadControl = $('#dealImage')[0]
    if fileUploadControl.files.length > 0
      file = fileUploadControl.files[0]
      name = 'photo.jpg'
      mainImage = new (Parse.File)(name, file)

    youtube = $('#youtube').val().trim()
    category = parseInt($('#category').val())

    unless (heading and mainImage and category >= 0)
      console.log heading, mainImage, category
      $("#create").html('Create').prop('disabled', false)
      return alert 'Please make sure that Heading, Image, and Category are sections are set'

    Deals = Parse.Object.extend("Deals")
    deal = new Deals()
    deal.set 'heading', heading
    deal.set 'mainImage', mainImage
    deal.set 'youtube_video_id', @getYoutubeIdFromURI(youtube) or ''
    deal.set 'category', category
    deal.set 'expiry', $('#date').data('DateTimePicker').date()._d

    # Get longitude and latitude
    postal_code = Parse.User.current().get('postal_code')
    console.log postal_code
    query_uri = "https://maps.googleapis.com/maps/api/geocode/json?address=#{ postal_code }"
    $.post query_uri, (ret)->
      console.log ret
      location = new Parse.GeoPoint(
        {
          latitude: ret.results[0].geometry.location.lat, 
          longitude: ret.results[0].geometry.location.lng
        })
      deal.set 'location', location
      deal.set 'owner', Parse.User.current()

      deal.save null, {
        success : ()->
          console.log 'saved'

          msg = heading
          if Parse.User.current().get('company_name')
            company_name = Parse.User.current().get('company_name')
            msg = "#{ heading } from #{ company_name }"
          Parse.Push.send {
            channels : ['global']
            data: alert: msg
          },
            success: ->
              window.location.href = "#dashboard"
              return console.log 'Push was successful'
            error: (error) ->
              return console.error error
          
        error :(error)->
          $("#create").html('Create').prop('disabled', false)
          console.error error
          alert 'error'
      }
      