# ================
# Echapson V1
# ================

# The current trail 
# @type {Object}
Session.set "trail", {}

# The current aside section. 
# There might be multiple sections in the future, so the 
# object contains an id property to distinguish them all.
# @type {Object}
Session.set "aside", {}


# ---- CLIENT ----

Meteor.Router.add 
  "/aprop/:part": (part) ->
    Session.set "aside", id: "aprop", part: part
    "aside"

  "/aprop": ->
    Session.set "aside", id: "aprop", part: "proj"
    "aside"

  "/trail/:tid/:pos": (tid, pos) -> 
    Session.set "trail", id: +tid, pos: +pos
    "trail"

  "*": -> 
    # TODO: The default route should be the last published element.
    Session.set "trail", id: 1, pos: 0
    "trail"




# ---- TPL: COMMONS ----


Handlebars.registerHelper "section", (it) -> 
  it == Meteor.Router.page() 

# Handlebars.registerHelper "iter", (ctx) ->
#   if ctx?.length 
#     ctx.reduce (acc, v, k) -> acc + _fn _.extend {}, val: v, index: k


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
    _r = "/aprop"
    if "aside" == Meteor.Router.page()
      _t = Session.get "trail"
      _r = if _t.id? then "/trail/#{_t.id}/#{_t.pos}" else "/"

    Meteor.Router.to _r



# ---- TPL: TRAIL ----

Template.trail._cur = null

Template.trail._fx = null

Template.trail.preserve [".ani.tr"]

Template.trail.helpers
  fx: -> 
    _t = Session.get "trail"
    if _t.id? && _t.id != Template.trail._cur 
      Template.trail._cur = _t.id
      Template.trail._fx = 
        switch Template.trail._fx
          when "fx2" then "fx1"
          when "fx1" then "fx2"
          when "" then "fx1"
          else ""
      Template.trail._fx


# ---- TPL: A PROPOS ----

Template.aside.$$ = {}

Template.aside.preserve [".ani.us-roll", ".ani.us-stt-roll"]

Template.aside.helpers
  pos: ->
    _p = Session.get "aside"
    Template.aside.$$.part = _p.part unless not _p.part
    "to-#{_p.part}" unless not _p.part

Template.aside.events
  "click .us-nav [class*='btn']": (e, tpl) ->
    Meteor.Router.to "/aprop/#{e.target.classList.item(1)}"

