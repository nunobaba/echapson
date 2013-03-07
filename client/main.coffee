# ================
# Echapson V1
# ================

# The current trail 
# @type {object}
Session.set "trail", {}


# ---- CLIENT ----

Meteor.Router.add 
  "/": -> 
    # Todo - Find the last element.
    Session.set "trail", id: 1, pos: 0
    "trail"

  "/nous": ->
    "aside"

  "/trail/:tid/:pos": (tid, pos) -> 
    Session.set "trail", id: +tid, pos: +pos
    "trail"



# ---- TPL: COMMONS ----


Handlebars.registerHelper "section", (it) -> 
  it == Meteor.Router.page() 



# ---- TPL: APPLICATION ----

# The Google Map singleton
# @type {google.maps.Map} 
Template.app._map = null

Template.app.preserve [".ani.chrome", "#logo", ".ani.chrome #mcan"]

Template.app.helpers
  page: -> 
    _p = Meteor.Router.page()
    if _p then "in-#{_p}" else ""

Template.app.rendered = ->
  if not Template.app._map
    Template.app._map = new google.maps.Map (@find "#mcan"), 
      center: new google.maps.LatLng 30, 20
      disableDefaultUI: true
      mapTypeId: google.maps.MapTypeId.ROADMAP
      maxZoom: 5
      minZoom: 3
      styles: Session.get "mapstyle"
      zoom: 3
      zoomControl: true
      zoomControlOptions: 
        position: google.maps.ControlPosition.LEFT_BOTTOM
        style: google.maps.ZoomControlStyle.SMALL

Template.app.events
  "click #logo": (e, tpl) ->
    _r = "/nous"
    if "aside" == Meteor.Router.page()
      _t = Session.get "trail"
      _r = if _t.id? then "/trail/#{_t.id}/#{_t.pos}" else "/"

    Meteor.Router.to _r



# ---- TPL: TRAIL ----

Template.trail._hist = null

Template.trail._fx = null

Template.trail.preserve [".ani.tr"]

Template.trail.helpers
  fx: -> 
    _t = Session.get "trail"
    if _t.id? && _t.id != Template.trail._hist 
      Template.trail._hist = _t.id
      Template.trail._fx = 
        switch Template.trail._fx
          when "fx2" then "fx1"
          when "fx1" then "fx2"
          when "" then "fx1"
          else ""
      Template.trail._fx


# ---- TPL: A PROPOS ----

# Template.aside.helpers



