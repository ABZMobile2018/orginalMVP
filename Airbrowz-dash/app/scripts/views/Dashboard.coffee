'use strict';

class Dash.Views.Dashboard extends Backbone.View

  template: JST['app/scripts/templates/Dashboard.html']

  tagName: 'div'

  id: ''

  className: ''

  events: {}

  initialize: () ->
    Parse.User.current().fetch().then (user)=>
      console.log user.toJSON()
      @user = Parse.User.current()
      query = new (Parse.Query)('Deals')
      query.equalTo 'owner', user
      query.find success: (deals)=>
        @collection = _.map deals, (deal) -> 
          return deal.toJSON()
        @render()

        # below code sucks
        # _.map @collection, (deal)=>
        #   latlng = "#{ deal.location.latitude },#{ deal.location.longitude }"
          
        #   $.post "http://maps.googleapis.com/maps/api/geocode/json?latlng=#{ latlng }", (ret)=>
        #     deal.address = ret.results[0].formatted_address
        #     @render()

  render: () ->
    output = Mustache.render @template(), { deals : @collection }
    @$el.html output
    
    _.map $('.time'), (ele)->
      time = $(ele).html()
      $(ele).html moment(time).fromNow()
