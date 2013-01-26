OPortfolioWebsite.Router.map ->
  this.route('welcome') 
  this.resource "entries", ->

OPortfolioWebsite.IndexRoute = Ember.Route.extend
  renderTemplate: (controller, data) ->
    loggedIn = false
    
    if(false) 
    else
      this.render('welcome');
      this.render('login',
        outlet: 'login',
        into: 'welcome'
      );
      this.render('register',
        outlet: 'register',
        into: 'welcome'
      );
    

OPortfolioWebsite.EntriesIndexRoute = Ember.Route.extend
  setupController: (controller, data) ->
    controller.set('content', OPortfolioWebsite.Entry.find())