window.Dash =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    'use strict'

    Dash.Parse = Parse
    Dash.Parse.initialize "D7VKvOCpa2Pnt8lr3dvynhVQxoDW6AgiXVsyQuB1", "Rs7IHkHHTTqv7O51TKwhNHMZnvQyvqrqUg5jn1pg"

    # Initialize the router
    new Dash.Routers.Routes()

$ ->
  'use strict'
  Dash.init();
  

