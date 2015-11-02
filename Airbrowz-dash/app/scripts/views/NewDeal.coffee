'use strict';

class Dash.Views.NewDeal extends Backbone.View

  template: JST['app/scripts/templates/NewDeal.html']

  tagName: 'div'

  id: 'main'

  events: {
    'click #create'    : 'create'
  }

  initialize: () ->
    @render()

  render: () ->
    @$el.html @template()

  getYoutubeIdFromURI: (uri) ->
    match = RegExp('[?&]v=([^&]*)').exec(uri)
    match and decodeURIComponent(match[1].replace(/\+/g, ' '))

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
    push_now = $('#push_now').val().trim()

    unless heading and mainImage and category
      return alert 'Please make sure that Heading, Image, and Category are sections are set'

    Deals = Parse.Object.extend("Deals");
    deal = new Deals()
    deal.set 'heading', heading
    deal.set 'mainImage', mainImage
    deal.set 'youtube_video_id', @getYoutubeIdFromURI(youtube)
    deal.set 'category', category

    # Get longitude and latitude
    postal_code = Parse.User.current().get('postal_code')
    query_uri = "http://maps.googleapis.com/maps/api/geocode/json?address=#{ postal_code }"
    $.post query_uri, (ret)->
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

          Parse.Push.send {
            channels : ['global']
            data: alert: heading
          },
            success: ->
              return console.log 'Push was successful'
            error: (error) ->
              return console.error error
          
          window.location.href="#dashboard"
          
        error :(error)->
          $("#create").html('Create').prop('disabled', false)
          console.error error
          alert 'error'
      }
      