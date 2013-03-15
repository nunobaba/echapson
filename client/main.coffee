# ================
# Echapson V1
# ================

Meteor.subscribe "trails"

# The current trail 
# @type {Object}
Session.set "trail", {}

# The current aside section. 
# There might be multiple sections in the future, so the 
# object contains an id property to distinguish them all.
# @type {Object}
Session.set "aside", {}


### Route navigation ###

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




### Handlebars helper functions ###

Handlebars.registerHelper "section", (it) -> 
  it == Meteor.Router.page() 


### Template: Application ###

# The Google Map singleton
# @type {google.maps.Map} 
Template.app._map = null

# Polylines and markers.
# @type {Object}
Template.app.$$ = 
  plines: []

Template.app.preserve [
  ".ani.chrome", "#logo", ".ani.chrome #mcan"]

Template.app.helpers
  page: -> 
    _p = Meteor.Router.page()
    if _p then "in-#{_p}" else ""

Template.app.rendered = ->
  _mstyle = Session.get "map.style"

  if not Template.app._map
    Template.app._map = new google.maps.Map (@find "#mcan"), 
      center: new google.maps.LatLng 30, 20
      disableDefaultUI: true
      mapTypeId: google.maps.MapTypeId.ROADMAP
      maxZoom: 5
      minZoom: 3
      styles: _mstyle.map
      zoom: 3
      zoomControl: true
      zoomControlOptions: 
        position: google.maps.ControlPosition.LEFT_BOTTOM
        style: google.maps.ZoomControlStyle.SMALL

    cursor = Trails.find()
    _LatLng = google.maps.LatLng
    _Marker = google.maps.Marker
    _Polyline = google.maps.Polyline

    # Trail paths are rendered as they arrive in the cursor.
    cursor.observe added: (tr) -> 
      pl = new _Polyline _mstyle.polyline.reg
      pl.id = tr.id
      pl.setMap Template.app._map
      pl.setPath tr.coords.map (latlng) -> 
        # Ensure only single markers are created. Those at the 
        # crossing of multiple polylines are just pulled from 
        # cache.
        markerId = latlng.toString()
        m = if markerId not of Template.app.$$
          new _Marker 
            id: latlng.toString()
            icon: _mstyle.marker.reg
            position: new _LatLng latlng[0], latlng[1]
            includes: []
            map: Template.app._map
        else
          Template.app.$$[markerId]
        m.includes.push pl.id
        m.getPosition()
      # Cache polylines.
      Template.app.$$[pl.id] = pl
      Template.app.$$.plines.push pl.id
    


Template.app.events
  "click #logo": (e, tpl) ->
    _r = "/aprop"
    if "aside" == Meteor.Router.page()
      _t = Session.get "trail"
      _r = if _t.id? then "/trail/#{_t.id}/#{_t.pos}" else "/"

    Meteor.Router.to _r



### Template: Trail Panel ###

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


### Template: Aside ###

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

