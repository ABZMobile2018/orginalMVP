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

  render: () ->
    console.log @collection
    output = Mustache.render @template(), { deals : @collection }
    @$el.html output
