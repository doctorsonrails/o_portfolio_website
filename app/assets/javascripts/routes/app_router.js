OPortfolioWebsite.Router.map(function() {
  this.resource("entries", function() {
    this.route('new');
    this.route('edit');
  });
});

/*
OPortfolioWebsite.Router = Ember.Router.extend({
  location: 'hash',

  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/',

      showEntries: Ember.Route.transitionTo('entries'),

      // You'll likely want to connect a view here.
      connectOutlets: function(router) {
          router.get('applicationController').connectOutlet('welcome');
      }

      // Layout your routes here...
    }),
    
    entries: Ember.Route.extend({
      route: '/entries',

      // You'll likely want to connect a view here.
      connectOutlets: function(router) {
          router.get('applicationController').connectOutlet("entries", OPortfolioWebsite.Entry.find());
      }

      // Layout your routes here...
    })
  })
});
*/