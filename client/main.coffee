# ================
# Echapson V1
# ================

Session.set "trail", {}

# ---- COMMON ----

Meteor.Router.add 
  "/": -> 
    # Todo - Find the last element.
    Session.set "trail", id: 1
    "trail"

  "/a": ->
    "aprop"

  "/t:rId": (rId) -> 
    Session.set "trail", id: rId
    "trail"


Handlebars.registerHelper "section", (it) -> 
  it == Meteor.Router.page() 


# ---- TPL: APPLICATION ----

Template.app._scr = null

Template.app.preserve [".ani.chrome"]

Template.app.helpers
  page: -> 
    _p = Meteor.Router.page()
    if _p then "in-#{_p}" else ""




# ---- TPL: TRAIL ----

Template.trail._hist = null

Template.trail._fx = null

Template.trail.preserve [".ani.tr"]

Template.trail.helpers
  fx: -> 
    _t = Session.get "trail"
    if _t.id? && _t.id != Template.trail._hist 
      Template.trail._hist = _t.id
      Template.trail._fx = switch Template.trail._fx
        when "fx2" then "fx1"
        when "fx1" then "fx2"
        when "" then "fx1"
        else ""
      Template.trail._fx

Template.trail.events 
  "webkitAnimationEnd #p0, 
  MSAnimationEnd #p0, 
  oanimationend #p0, 
  animationend #p0": (e, tpl) -> 
    # Excluse the case of the staging animation.
    console.log Template.trail._fx



# ---- TPL: A PROPOS ----

# Template.aprop.helpers



# ---- TPL: BUTTONS ----

Template.controls.events
  "keyup": (e) ->
    if e.keyCode == 13
      Meteor.Router.to "/" + document.getElementById("path").value
