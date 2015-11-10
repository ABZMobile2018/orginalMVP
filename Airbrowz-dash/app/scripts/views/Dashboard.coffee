'use strict';

class Dash.Views.Dashboard extends Backbone.View

  template: JST['app/scripts/templates/Dashboard.html']

  tagName: 'div'

  id: 'main'

  className: ''

  events: {
    'click .delete' : 'delete'
  }

  initialize: () ->
    Parse.User.current().fetch().then (user)=>
      @user = Parse.User.current()
      query = new (Parse.Query)('Deals')
      query.equalTo 'owner', user
      query.find success: (deals)=>
        @collection = _.map deals, (deal) -> 
          return deal.toJSON()
        @render()

  render: () ->
    output = Mustache.render @template(), { user : @user.toJSON() ,deals : @collection }
    @$el.html output
    
    _.map $('.time'), (ele)->
      time = $(ele).html()
      $(ele).html moment(time).from(new Date())

    _.map $('.valid-time'), (ele)->
      time = $(ele).html()
      time = moment(time).from(new Date())
      if time.indexOf('ago') > -1
        return $(ele).html "Expired #{ time }"
      $(ele).html "Expires #{ time }"

    _.map $('.viwedBy'), (ele)->
      time = $(ele).attr('data-created-at')
      numbViewed = (new Date()).getTime() - (new Date(time)).getTime()
      numbViewed  = parseInt numbViewed/10000
      numbViewed = parseInt(numbViewed / 10) while numbViewed > 1000

      numbReached = numbViewed + 123
      clickRate = numbViewed/numbReached * 100
      clickRate = parseInt clickRate
      $(ele).html "<p>Reached #{ numbReached } people</p> <p>Click rate #{ clickRate }% (#{ numbViewed } people)</p>"

  delete : (e)->
    e.preventDefault()
    target = e.target
    objectId = target.getAttribute('data-object-id')
    Deal = Parse.Object.extend('Deals')
    deal = new Deal()
    deal.set 'objectId', objectId
    deal.destroy
      success:()=>
        console.log 'deal destroyed'
        query = new (Parse.Query)('Deals')
        query.equalTo 'owner', @user
        query.find success: (deals)=>
          @collection = _.map deals, (deal) -> 
            return deal.toJSON()
          @render()
      error:()=>
        console.error 'error'
