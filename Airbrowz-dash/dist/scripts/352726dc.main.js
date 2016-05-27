(function(){window.Dash={Models:{},Collections:{},Views:{},Routers:{},init:function(){"use strict";return Dash.Parse=Parse,Dash.Parse.initialize("D7VKvOCpa2Pnt8lr3dvynhVQxoDW6AgiXVsyQuB1","Rs7IHkHHTTqv7O51TKwhNHMZnvQyvqrqUg5jn1pg"),new Dash.Routers.Routes}},$(function(){"use strict";return Dash.init()})}).call(this),this.JST=this.JST||{},this.JST["app/scripts/templates/Dashboard.html"]=function(obj){obj||(obj={});var __p="";_.escape;with(obj)__p+='<div style="height:100px;"></div>\n<div class="container">\n\n  \n  <div class="row">\n    {{#user}}\n    <div class="col-md-4">\n\n      <div class="text-center card">\n        <img src="{{company_logo.url}}" class="merchant-logo">\n        <h4>{{company_name}}</h4>\n        <hr>\n        <p>{{description}}</p>\n      </div>\n\n      <hr>\n\n      <div class="card">\n        <h4 style="display: inline;">About</h4> · <a href="#edit">Edit</a>\n        <hr>\n        <p><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span> {{email}}</p> \n\n        <p><span class="glyphicon glyphicon-map-marker"></span> {{street_number}} {{street_name}} {{city}} {{province}} {{postal_code}}</p>\n\n        <p><span class="glyphicon glyphicon-earphone"></span> {{phone}}</p>\n\n        <p><a href="https://facebook.com/{{facebook_id}}">https://facebook.com/{{facebook_id}}</a></p>\n        \n        <p class="text-right"><u><a href="#logout">Logout</a></u></p>\n      </div>\n\n      <hr>\n\n      <div class="card" style="margin-bottom:20px;">\n        <span style="padding-right:10px;">123 People Nearby</span> \n        <a class="btn btn-info" href="#newDeal">+ Add A New Deal</a>\n      </div>\n    </div>\n    {{/user}}\n\n    <div class="col-md-8">\n\n      {{#deals}}\n      <div class="row card">\n        <div class="col-md-6">\n          <img src="{{mainImage.url}}" style="width:100%;"/>\n        </div>\n        <div class="col-md-6">\n          <p><strong>{{heading}}</strong></p>\n\n          <p>Created <span class="time">{{createdAt}}</span></p>\n\n          <p class="valid-time">{{expiry.iso}}</p>\n\n          <div class="viwedBy" data-created-at="{{createdAt}}">\n            287\n          </div>\n          <p class="text-right">\n            <button class="delete btn btn-danger" data-object-id={{objectId}}>Delete</button>\n          </p>\n\n        </div>\n       \n      </div>\n      <div style="height:10px;"></div>\n      {{/deals}}\n\n    </div>\n  </div>\n\n</div>';return __p},this.JST["app/scripts/templates/EditProfile.html"]=function(obj){obj||(obj={});var __p="";_.escape;with(obj)__p+='{{#user}}\n<div style="height:10vh;"></div>\n<div class="container card">\n\n  <form class="form-horizontal">\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Company Name (*)</label>\n      <div class="col-sm-10">\n        <input type="text" class="form-control" id="company_name" placeholder="Company Name" value="{{company_name}}">\n      </div>\n    </div>\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Company Logo (*)</label>\n      <div class="col-sm-4 col-sm-offset-3">\n        <img src="{{company_logo.url}}">\n        <input type="file" class="form-control" id="company_logo" placeholder="Company Name">\n      </div>\n    </div>\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Password (*)</label>\n      <div class="col-sm-10">\n        <input type="password" class="form-control" id="password" placeholder="Password">\n      </div>\n    </div>\n    \n    <div class="form-group">\n      <label class="col-sm-2 control-label">Description (*)</label>\n      <div class="col-sm-10">\n        <textarea id="description" rows="3" style="width:100%;padding: 20px;">{{description}}</textarea>\n      </div>\n    </div>\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Phone Number (*)</label>\n      <div class="col-sm-10">\n        <input type="text" class="form-control" id="phone_number" placeholder="123-123-1234" value="{{phone}}">\n      </div>\n    </div>\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Address (*)</label>\n\n      <div class="col-sm-10">\n        <div class="row">\n          <div class="col-sm-2">\n            <input id="street_number" type="text" class="form-control" placeholder="Street #" value="{{street_number}}"/>\n          </div>\n          <div class="col-sm-8">\n            <input id="street_name" type="text" class="form-control" placeholder="Street Name" value="{{street_name}}"/>\n          </div>\n          <div class="col-sm-2">\n            <input id="postal_code" type="text" class="form-control" placeholder="Postal Code" value="{{postal_code}}"/>\n          </div>\n        </div>\n        <div class="row" style="margin-top:10px;">\n          <div class="col-sm-8">\n            <input id="city" type="text" class="form-control" placeholder="City" value="city"/>\n          </div>\n          <div class="col-sm-4">\n            <input id="province" type="text" class="form-control" placeholder="Province" value="{{province}}"/>\n          </div>\n        </div>\n      </div>\n    </div>\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Facebook Link</label>\n      <div class="col-sm-10">\n        <input type="text" class="form-control" id="facebook" placeholder="Facebook Link" value="{{facebook_id}}">\n      </div>\n    </div>\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Hours of Operation (*)</label>\n      <div class="table-responsive">\n        <table class="table text-center">\n          <thead>\n            <tr>\n              <td>&nbsp;</td>\n              <td>Monday</td>\n              <td>Tuesday</td>\n              <td>Wednesday</td>\n              <td>Thursday</td>\n              <td>Friday</td>\n              <td>Satureday</td>\n              <td>Sunday</td>\n            </tr>\n          </thead>\n          <tbody>\n            <tr>\n              <td>Open</td>\n              <td><input id="mon_open" type="time" value="10:00"></td>\n              <td><input id="tue_open" type="time" value="10:00"></td>\n              <td><input id="wed_open" type="time" value="10:00"></td>\n              <td><input id="thu_open" type="time" value="10:00"></td>\n              <td><input id="fri_open" type="time" value="10:00"></td>\n              <td><input id="sat_open" type="time" value="10:00"></td>\n              <td><input id="sun_open" type="time" value="10:00"></td>\n            </tr>\n            <tr>\n              <td>Close</td>\n              <td><input id="mon_close" type="time" value="21:00"></td>\n              <td><input id="tue_close" type="time" value="21:00"></td>\n              <td><input id="wed_close" type="time" value="21:00"></td>\n              <td><input id="thu_close" type="time" value="21:00"></td>\n              <td><input id="fri_close" type="time" value="21:00"></td>\n              <td><input id="sat_close" type="time" value="21:00"></td>\n              <td><input id="sun_close" type="time" value="21:00"></td>\n            </tr>\n          </tbody>\n        </table>\n        \n      </div>\n    </div>\n\n\n    <div class="form-group">\n      <div class="col-sm-2 col-sm-offset-10 text-right">\n      <p>(*) are required fields</p>\n      <a id="cancel" href="#dashboard" class="btn btn-default">Cancel</a>\n        <button id="save" type="submit" class="btn btn-info">Save</button>\n      </div>\n    </div>\n\n  </form>\n</div>\n{{/user}}';return __p},this.JST["app/scripts/templates/Landing.html"]=function(obj){obj||(obj={});var __p="";_.escape;with(obj)__p+='<div class="landing">\n    <div class="login-form">\n        <h1>Welcome to Airbrowz</h1>\n        <p>Merchant login</p>\n        <form class="form-inline">\n          <div class="form-group">\n            <label class="sr-only" for="email">Email</label>\n            <input id="email" type="email" class="form-control" placeholder="Email">\n          </div>\n          <div class="form-group">\n            <label class="sr-only" for="password">Password</label>\n            <input id="password" type="password" class="form-control" placeholder="Password">\n          </div>\n          \n          <button id="login" type="submit" class="btn btn-primary">Sign in</button>\n\n          <p style="margin-top:10px;">\n            <a href="#signup" style="color:white;">Create a new account</a>\n          </p>\n        </form>\n    </div>\n</div>';return __p},this.JST["app/scripts/templates/NewDeal.html"]=function(obj){obj||(obj={});var __p="";_.escape;with(obj)__p+='<div style="height:100px;"></div>\n<div class="container">\n\n  <form class="form-horizontal card">\n    <p class="text-right" style="margin-bottom:20px;">(*) are required fields</p>\n\n    <div class="form-group">\n      <label class="col-sm-3 control-label">Heading (*)</label>\n      <div class="col-sm-8">\n        <input id=\'heading\' type="text" class="form-control" placeholder="Deal Title">\n      </div>\n    </div>\n\n    <div style="height:2vh;"></div>\n\n    <div class="form-group">\n      <label class="col-sm-3 control-label">Valid until (*)</label>\n      <div class="col-sm-5 col-sm-offset-1">\n        <div id=\'date\'></div>\n      </div>\n    </div>\n\n    <div style="height:2vh;"></div>\n\n    <div class="form-group">\n      <label class="col-sm-3 control-label">\n        Image (*)<br>\n        (Recommened size 800x640)\n      </label>\n\n      <div class="col-sm-6">\n        <i  id="spinner" class="fa fa-refresh fa-spin fa-4x hidden"></i>\n        <img id="thumbnail" src="" class="hidden">\n        <input type="file" id="dealImage">\n      </div>\n    </div>\n\n    <div style="height:2vh;"></div>\n\n    <div class="form-group">\n      <label class="col-sm-3 control-label">Youtube Link</label>\n      <div class="col-sm-8">\n        <input id="youtube" type="text" class="form-control" placeholder="Optional">\n      </div>\n    </div>\n\n    <div style="height:2vh;"></div>\n\n    <div class="form-group">\n      <label class="col-sm-3 control-label">Category (*)</label>\n      <div class="col-sm-8">\n        <select id="category" class="form-control">\n          <option>-- Select --</option>\n          <option value="0">Maternity & Children’s wear</option>\n          <option value="1">Men’s Fashion</option>\n          <option value="2">Women’s Fashion</option>\n          ​<option value="3">Books, Music, Games & Gifts</option>\n          <option value="4">Computers, Tablets & Mobiles</option>\n          <option value="5">Handbags & Footwear</option>\n          <option value="6">Health & Beauty</option>\n          <option value="7">Fitness & Well-Being</option>\n          <option value="8">Food & Drink</option>\n          <option value="9">Electronics & Entertainment</option>\n          <option value="10">Automotive</option>\n          <option value="11">Home & Garden</option>\n          <option value="12">Services</option>\n          <option value="13">Sports, Outdoor & Travel</option>\n          <option value="14">Events</option>\n          <option value="15">Grocery</option>\n          <option value="16">Misc</option>\n        </select>\n      </div>\n    </div>\n\n    <div class="form-group">\n      <div class="col-md-4 col-md-offset-8 text-right">\n        <a class="btn btn-default btn-lg" href="#dashboard">\n          Cancel\n        </a>\n        <button class="btn btn-info btn-lg" id="create">Create</button>\n      </div>\n    </div>\n\n  </form>\n</div>\n';return __p},this.JST["app/scripts/templates/Signup.html"]=function(obj){obj||(obj={});var __p="";_.escape;with(obj)__p+='<div style="height:10vh;"></div>\n<div class="container card">\n\n  <form class="form-horizontal">\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Company Name (*)</label>\n      <div class="col-sm-10">\n        <input type="text" class="form-control" id="company_name" placeholder="Company Name">\n      </div>\n    </div>\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Company Logo (*)</label>\n      <div class="col-sm-10">\n        <input type="file" class="form-control" id="company_logo" placeholder="Company Name">\n      </div>\n    </div>\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Email (*)</label>\n      <div class="col-sm-10">\n        <input type="email" class="form-control" id="email" placeholder="Email">\n      </div>\n    </div>\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Password (*)</label>\n      <div class="col-sm-10">\n        <input type="password" class="form-control" id="password" placeholder="Password">\n      </div>\n    </div>\n    \n    <div class="form-group">\n      <label class="col-sm-2 control-label">Description (*)</label>\n      <div class="col-sm-10">\n        <textarea id="description" rows="3" style="width:100%;"></textarea>\n      </div>\n    </div>\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Phone Number (*)</label>\n      <div class="col-sm-10">\n        <input type="text" class="form-control" id="phone_number" placeholder="123-123-1234">\n      </div>\n    </div>\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Address (*)</label>\n\n      <div class="col-sm-10">\n        <div class="row">\n          <div class="col-sm-2">\n            <input id="street_number" type="text" class="form-control" placeholder="Street #" />\n          </div>\n          <div class="col-sm-8">\n            <input id="street_name" type="text" class="form-control" placeholder="Street Name" />\n          </div>\n          <div class="col-sm-2">\n            <input id="postal_code" type="text" class="form-control" placeholder="Postal Code" />\n          </div>\n        </div>\n        <div class="row" style="margin-top:10px;">\n          <div class="col-sm-8">\n            <input id="city" type="text" class="form-control" placeholder="City" />\n          </div>\n          <div class="col-sm-4">\n            <input id="province" type="text" class="form-control" placeholder="Province" />\n          </div>\n        </div>\n      </div>\n    </div>\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Facebook Link</label>\n      <div class="col-sm-10">\n        <input type="text" class="form-control" id="facebook" placeholder="Facebook Link">\n      </div>\n    </div>\n\n    <div class="form-group">\n      <label class="col-sm-2 control-label">Hours of Operation (*)</label>\n      <div class="table-responsive">\n        <table class="table text-center">\n          <thead>\n            <tr>\n              <td>&nbsp;</td>\n              <td>Monday</td>\n              <td>Tuesday</td>\n              <td>Wednesday</td>\n              <td>Thursday</td>\n              <td>Friday</td>\n              <td>Satureday</td>\n              <td>Sunday</td>\n            </tr>\n          </thead>\n          <tbody>\n            <tr>\n              <td>Open</td>\n              <td><input id="mon_open" type="time" value="10:00"></td>\n              <td><input id="tue_open" type="time" value="10:00"></td>\n              <td><input id="wed_open" type="time" value="10:00"></td>\n              <td><input id="thu_open" type="time" value="10:00"></td>\n              <td><input id="fri_open" type="time" value="10:00"></td>\n              <td><input id="sat_open" type="time" value="10:00"></td>\n              <td><input id="sun_open" type="time" value="10:00"></td>\n            </tr>\n            <tr>\n              <td>Close</td>\n              <td><input id="mon_close" type="time" value="21:00"></td>\n              <td><input id="tue_close" type="time" value="21:00"></td>\n              <td><input id="wed_close" type="time" value="21:00"></td>\n              <td><input id="thu_close" type="time" value="21:00"></td>\n              <td><input id="fri_close" type="time" value="21:00"></td>\n              <td><input id="sat_close" type="time" value="21:00"></td>\n              <td><input id="sun_close" type="time" value="21:00"></td>\n            </tr>\n          </tbody>\n        </table>\n        \n      </div>\n    </div>\n\n\n    <div class="form-group text-right">\n      <p>(*) are required fields</p>\n    </div>\n\n    <div class="form-group">\n      <div class="col-sm-1 col-sm-offset-11">\n        <button id="register" type="submit" class="btn btn-info">Register</button>\n      </div>\n    </div>\n\n  </form>\n</div>';return __p},function(){"use strict";var a,b={}.hasOwnProperty,c=function(a,c){function d(){this.constructor=a}for(var e in c)b.call(c,e)&&(a[e]=c[e]);return d.prototype=c.prototype,a.prototype=new d,a.__super__=c.prototype,a};Dash.Models.User=function(b){function d(){return a=d.__super__.constructor.apply(this,arguments)}return c(d,b),d.prototype.url="",d.prototype.initialize=function(){},d.prototype.defaults={},d.prototype.validate=function(a,b){},d.prototype.parse=function(a,b){return a},d}(Backbone.Model)}.call(this),function(){"use strict";var a,b={}.hasOwnProperty,c=function(a,c){function d(){this.constructor=a}for(var e in c)b.call(c,e)&&(a[e]=c[e]);return d.prototype=c.prototype,a.prototype=new d,a.__super__=c.prototype,a};Dash.Views.Landing=function(b){function d(){return a=d.__super__.constructor.apply(this,arguments)}return c(d,b),d.prototype.template=JST["app/scripts/templates/Landing.html"],d.prototype.tagName="div",d.prototype.id="main",d.prototype.className="",d.prototype.events={"click #login":"login"},d.prototype.initialize=function(){return this.render()},d.prototype.render=function(){return this.$el.html(this.template())},d.prototype.login=function(a){var b,c;return a.preventDefault(),console.log("login"),b=$("#email").val(),c=$("#password").val(),Parse.User.logOut(),Parse.User.logIn(b,c,{success:function(a){window.location.href="#dashboard"},error:function(a,b){alert("Wrong email/password. Please try again")}})},d}(Backbone.View)}.call(this),function(){"use strict";var a,b={}.hasOwnProperty,c=function(a,c){function d(){this.constructor=a}for(var e in c)b.call(c,e)&&(a[e]=c[e]);return d.prototype=c.prototype,a.prototype=new d,a.__super__=c.prototype,a};Dash.Routers.Routes=function(b){function d(){return a=d.__super__.constructor.apply(this,arguments)}return c(d,b),d.prototype.routes={"":"landing",signup:"signup",dashboard:"dashboard",newDeal:"newDeal",edit:"edit",logout:"logout"},d.prototype.initialize=function(){return Backbone.history.start()},d.prototype.landing=function(){return console.log("landing"),new Dash.Views.Landing({el:$("#main")[0]})},d.prototype.dashboard=function(){return console.log("dashboard"),Parse.User.current()?new Dash.Views.Dashboard({el:$("#main")[0]}):(console.log("need to authenticate"),window.location.href="/")},d.prototype.signup=function(){return console.log("signup"),new Dash.Views.Signup({el:$("#main")[0]})},d.prototype.newDeal=function(){return console.log("new deal"),new Dash.Views.NewDeal({el:$("#main")[0]})},d.prototype.edit=function(){return new Dash.Views.EditProfile({el:$("#main")[0]})},d.prototype.logout=function(){return Parse.User.logOut(),window.location.href="/"},d}(Backbone.Router)}.call(this),function(){"use strict";var a,b={}.hasOwnProperty,c=function(a,c){function d(){this.constructor=a}for(var e in c)b.call(c,e)&&(a[e]=c[e]);return d.prototype=c.prototype,a.prototype=new d,a.__super__=c.prototype,a};Dash.Views.Signup=function(b){function d(){return a=d.__super__.constructor.apply(this,arguments)}return c(d,b),d.prototype.template=JST["app/scripts/templates/Signup.html"],d.prototype.tagName="div",d.prototype.id="main",d.prototype.className="",d.prototype.events={"click #register":"signup"},d.prototype.initialize=function(){return this.render()},d.prototype.render=function(){return Parse.User.logOut(),this.$el.html(this.template()),$("#phone_number").inputmask("mask",{mask:"(999) 999 - 9999"})},d.prototype.setHoursOfOperationToModel=function(a){var b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t;for(h=$("#mon_open").val(),g=$("#mon_close").val(),p=$("#tue_open").val(),o=$("#tue_close").val(),r=$("#wed_open").val(),q=$("#wed_close").val(),n=$("#thu_open").val(),m=$("#thu_close").val(),c=$("#fri_open").val(),b=$("#fri_close").val(),j=$("#sat_open").val(),i=$("#sat_close").val(),l=$("#sun_open").val(),k=$("#sun_close").val(),e=[[h,g],[p,o],[r,q],[n,m],[c,b],[j,i],[l,k]],f=s=0,t=e.length;t>s;f=++s)d=e[f],(""===d[0]||""===d[1])&&(e[f]=[]);return a.set("hours_of_operation",e)},d.prototype.signup=function(a){var b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q;return a.preventDefault(),c=$("#company_name").val().trim(),e=$("#email").val().trim(),k=$("#password").val().trim(),d=$("#description").val().trim(),p=$("#street_number").val().trim(),o=$("#street_name").val().trim(),m=$("#postal_code").val().trim(),b=$("#city").val().trim(),n=$("#province").val().trim(),f=$("#facebook").val().trim(),l=$("#phone_number").val().trim(),f.length>0&&(f=f.replace("://","").split("/")[1]),h=$("#company_logo")[0],h.files.length>0&&(g=h.files[0],j="logo.jpg",i=new Parse.File(j,g)),e&&k&&d&&p&&o&&m&&b&&n&&i&&c?(q=new Parse.User,q.set("username",e),q.set("password",k),q.set("email",e),q.set("description",d),q.set("street_number",p),q.set("street_name",o),q.set("postal_code",m),q.set("city",b),q.set("province",n),q.set("company_logo",i),q.set("company_name",c),q.set("phone",l),q.set("facebook_id",f),this.setHoursOfOperationToModel(q),q.signUp(null,{success:function(a){window.location.href="#dashboard"},error:function(a,b){alert("Error: "+b.code+" "+b.message)}})):alert("Please fill in all the textboxes")},d}(Backbone.View)}.call(this),function(){"use strict";var a,b={}.hasOwnProperty,c=function(a,c){function d(){this.constructor=a}for(var e in c)b.call(c,e)&&(a[e]=c[e]);return d.prototype=c.prototype,a.prototype=new d,a.__super__=c.prototype,a};Dash.Views.Dashboard=function(b){function d(){return a=d.__super__.constructor.apply(this,arguments)}return c(d,b),d.prototype.template=JST["app/scripts/templates/Dashboard.html"],d.prototype.tagName="div",d.prototype.id="main",d.prototype.className="",d.prototype.events={"click .delete":"delete"},d.prototype.initialize=function(){var a=this;return Parse.User.current().fetch().then(function(b){var c;return a.user=Parse.User.current(),c=new Parse.Query("Deals"),c.equalTo("owner",b),c.find({success:function(b){return a.collection=_.map(b,function(a){return a.toJSON()}),a.render()}})})},d.prototype.render=function(){var a;return a=Mustache.render(this.template(),{user:this.user.toJSON(),deals:this.collection}),this.$el.html(a),_.map($(".time"),function(a){var b;return b=$(a).html(),$(a).html(moment(b).from(new Date))}),_.map($(".valid-time"),function(a){var b;return b=$(a).html(),b=moment(b).from(new Date),b.indexOf("ago")>-1?$(a).html("Expired "+b):$(a).html("Expires "+b)}),_.map($(".viwedBy"),function(a){var b,c,d,e;for(e=$(a).attr("data-created-at"),d=(new Date).getTime()-new Date(e).getTime(),d=parseInt(d/1e4);d>1e3;)d=parseInt(d/10);return c=d+123,b=d/c*100,b=parseInt(b),$(a).html("<p>Reached "+c+" people</p> <p>Click rate "+b+"% ("+d+" people)</p>")})},d.prototype["delete"]=function(a){var b,c,d,e,f=this;return a.preventDefault(),e=a.target,d=e.getAttribute("data-object-id"),b=Parse.Object.extend("Deals"),c=new b,c.set("objectId",d),c.destroy({success:function(){var a;return console.log("deal destroyed"),a=new Parse.Query("Deals"),a.equalTo("owner",f.user),a.find({success:function(a){return f.collection=_.map(a,function(a){return a.toJSON()}),f.render()}})},error:function(){return console.error("error")}})},d}(Backbone.View)}.call(this),function(){"use strict";var a,b={}.hasOwnProperty,c=function(a,c){function d(){this.constructor=a}for(var e in c)b.call(c,e)&&(a[e]=c[e]);return d.prototype=c.prototype,a.prototype=new d,a.__super__=c.prototype,a};Dash.Views.NewDeal=function(b){function d(){return a=d.__super__.constructor.apply(this,arguments)}return c(d,b),d.prototype.template=JST["app/scripts/templates/NewDeal.html"],d.prototype.tagName="div",d.prototype.id="main",d.prototype.events={"click #create":"create","change #dealImage":"fileSelected"},d.prototype.initialize=function(){return this.render()},d.prototype.render=function(){var a;return this.$el.html(this.template()),$("#date").datetimepicker({inline:!0,sideBySide:!0,useCurrent:!0}),$("#date").data("DateTimePicker").minDate(new Date),a=new Date,a.setHours(a.getHours()+5),$("#date").data("DateTimePicker").date(a)},d.prototype.generateUUID=function(){var a;return a=function(){return Math.floor(65536*(1+Math.random())).toString(16).substring(1)},a()+a()+a()+a()+a()+a()+a()+a()},d.prototype.getYoutubeIdFromURI=function(a){var b;return b=RegExp("[?&]v=([^&]*)").exec(a),b&&decodeURIComponent(b[1].replace(/\+/g," "))},d.prototype.fileSelected=function(a){var b,c,d,e,f,g;return d=$("#dealImage")[0],d.files.length>0?($("#spinner").removeClass("hidden"),c=d.files[0],f=this.generateUUID(),e=new Parse.File(f,c),b=Parse.Object.extend("TempImages"),g=new b,g.set("file",e),g.save({success:function(a){var b;return b=a.get("file")._url,$("#thumbnail").attr("src",b),$("#thumbnail").removeClass("hidden"),$("#spinner").addClass("hidden")}})):void 0},d.prototype.create=function(a){var b,c,d,e,f,g,h,i,j,k,l;return a.preventDefault(),$("#create").html("submitting...").prop("disabled",!0),g=$("#heading").val(),f=$("#dealImage")[0],f.files.length>0&&(e=f.files[0],i="photo.jpg",h=new Parse.File(i,e)),l=$("#youtube").val().trim(),c=parseInt($("#category").val()),g&&h&&c>=0?(b=Parse.Object.extend("Deals"),d=new b,d.set("heading",g),d.set("mainImage",h),d.set("youtube_video_id",this.getYoutubeIdFromURI(l)||""),d.set("category",c),d.set("expiry",$("#date").data("DateTimePicker").date()._d),j=Parse.User.current().get("postal_code"),console.log(j),k="http://maps.googleapis.com/maps/api/geocode/json?address="+j,$.post(k,function(a){var b;return console.log(a),b=new Parse.GeoPoint({latitude:a.results[0].geometry.location.lat,longitude:a.results[0].geometry.location.lng}),d.set("location",b),d.set("owner",Parse.User.current()),d.save(null,{success:function(){var a,b;return console.log("saved"),b=g,Parse.User.current().get("company_name")&&(a=Parse.User.current().get("company_name"),b=""+g+" from "+a),Parse.Push.send({channels:["global"],data:{alert:b}},{success:function(){return window.location.href="#dashboard",console.log("Push was successful")},error:function(a){return console.error(a)}})},error:function(a){return $("#create").html("Create").prop("disabled",!1),console.error(a),alert("error")}})})):(console.log(g,h,c),$("#create").html("Create").prop("disabled",!1),alert("Please make sure that Heading, Image, and Category are sections are set"))},d}(Backbone.View)}.call(this),function(){"use strict";var a,b={}.hasOwnProperty,c=function(a,c){function d(){this.constructor=a}for(var e in c)b.call(c,e)&&(a[e]=c[e]);return d.prototype=c.prototype,a.prototype=new d,a.__super__=c.prototype,a};Dash.Views.EditProfile=function(b){function d(){return a=d.__super__.constructor.apply(this,arguments)}return c(d,b),d.prototype.template=JST["app/scripts/templates/EditProfile.html"],d.prototype.tagName="div",d.prototype.id="",d.prototype.className="",d.prototype.events={"click #save":"save"},d.prototype.initialize=function(){var a=this;return Parse.User.current().fetch().then(function(b){return a.user_model=Parse.User.current(),a.render()})},d.prototype.render=function(){var a;return a=Mustache.render(this.template(),{user:this.user_model.toJSON()}),this.$el.html(a),$("#phone_number").inputmask("mask",{mask:"(999) 999 - 9999"}),this.displayHours()},d.prototype.setHoursOfOperationToModel=function(){var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s;for(g=$("#mon_open").val(),f=$("#mon_close").val(),o=$("#tue_open").val(),n=$("#tue_close").val(),q=$("#wed_open").val(),p=$("#wed_close").val(),m=$("#thu_open").val(),l=$("#thu_close").val(),b=$("#fri_open").val(),a=$("#fri_close").val(),i=$("#sat_open").val(),h=$("#sat_close").val(),k=$("#sun_open").val(),j=$("#sun_close").val(),d=[[g,f],[o,n],[q,p],[m,l],[b,a],[i,h],[k,j]],e=r=0,s=d.length;s>r;e=++r)c=d[e],(""===c[0]||""===c[1])&&(d[e]=[]);return this.user_model.set("hours_of_operation",d)},d.prototype.displayHours=function(){var a;return a=this.user_model.get("hours_of_operation"),$("#mon_open").val(a[0][0]),$("#mon_close").val(a[0][1]),$("#tue_open").val(a[1][0]),$("#tue_close").val(a[1][1]),$("#wed_open").val(a[2][0]),$("#wed_close").val(a[2][1]),$("#thu_open").val(a[3][0]),$("#thu_close").val(a[3][1]),$("#fri_open").val(a[4][0]),$("#fri_close").val(a[4][1]),$("#sat_open").val(a[5][0]),$("#sat_close").val(a[5][1]),$("#sun_open").val(a[6][0]),$("#sun_close").val(a[6][1])},d.prototype.save=function(a){var b,c,d,e,f,g,h,i,j,k,l,m,n,o=this;return a.preventDefault(),c=$("#company_name").val().trim(),i=$("#password").val().trim(),d=$("#description").val().trim(),n=$("#street_number").val().trim(),m=$("#street_name").val().trim(),k=$("#postal_code").val().trim(),b=$("#city").val().trim(),l=$("#province").val().trim(),e=$("#facebook").val().trim(),j=$("#phone_number").val().trim(),e.length>0&&(e=e.replace("://","").split("/")[1]),g=$("#company_logo")[0],g.files.length>0&&(f=g.files[0],h=new Parse.File("logo.jpg",f),this.user_model.set("company_logo",h)),this.user_model.set("description",d),this.user_model.set("street_number",n),this.user_model.set("street_name",m),this.user_model.set("postal_code",k),this.user_model.set("city",b),this.user_model.set("province",l),this.user_model.set("company_name",c),this.user_model.set("facebook_id",e),this.user_model.set("phone",j),this.setHoursOfOperationToModel(),i?(this.user_model.set("password",i),this.user_model.save({success:function(){return console.log(o.user_model.get("email"),i),Parse.User.logOut(),Parse.User.logIn(o.user_model.get("email"),i,{success:function(a){return window.location.href="#dashboard"}})},error:function(a){}})):this.user_model.save({success:function(){return window.location.href="#dashboard"},error:function(){}})},d}(Backbone.View)}.call(this);