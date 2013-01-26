OPortfolioWebsite.Router.map -> 
  this.resource "entries", ->

OPortfolioWebsite.EntriesIndexRoute = Ember.Route.extend
  setupController: (controller, data) ->
    controller.set('content', OPortfolioWebsite.Entry.find())