# global beforeEach, describe, it, assert, expect
"use strict"

describe 'User Model', ->
  beforeEach ->
    @UserModel = new Dash.Models.User();
