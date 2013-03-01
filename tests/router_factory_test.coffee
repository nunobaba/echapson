# Test of the RouterFactory

should = require("should")
sinon = require("sinon")
Backbone = require("backbone")
RouterFactory = require("../client/lib/router_factory.coffee").RouterFactory

describe "Routing", ->
  items = 
    find: sinon.spy()

  factory = new RouterFactory(Backbone, items)
  router = factory.getRouter()

  it "should have an index router", ->
    router.routes[""].should.equal("index")

  it "should retrieve all items when navigating to index", ->
    router.index()
    items.find.called.should.equal true