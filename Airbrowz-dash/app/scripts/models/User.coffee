'use strict';

class Dash.Models.User extends Backbone.Model
  url: '',

  initialize: () ->

  defaults: {}

  validate: (attrs, options) ->

  parse: (response, options) ->
    response
