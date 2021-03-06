'use strict';

class Dash.Routers.Routes extends Backbone.Router

  routes:
    ""          : "landing"
    "signup"    : "signup"
    "dashboard" : "dashboard"
    "newDeal"   : "newDeal"
    "edit"      : "edit"
    "logout"    : "logout"


  initialize :->
    Backbone.history.start()

  landing : ->
    console.log 'landing'
    new Dash.Views.Landing( el:$('#main')[0] )

  dashboard :->
    console.log 'dashboard'
    unless Parse.User.current()
      console.log 'need to authenticate'
      return window.location.href = '/' 
    new Dash.Views.Dashboard( el:$('#main')[0] )

  signup :->
    console.log 'signup'
    new Dash.Views.Signup( el:$('#main')[0] )

  newDeal :->
    console.log 'new deal'
    new Dash.Views.NewDeal( el:$('#main')[0] )

  edit : ->
    new Dash.Views.EditProfile( el:$('#main')[0] )

  logout :->
    Parse.User.logOut()
    window.location.href = '/'