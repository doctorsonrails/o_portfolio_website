attr = DS.attr
OPortfolioWebsite.Entry = DS.Model.extend
    title: attr("string")

###
OPortfolioWebsite.Entry = Ember.Object.extend();
OPortfolioWebsite.Entry.reopenClass
  _all: [{title:'Bernard goes to school'},{title:'LJ goes to work!!'}]
  find: -> @_all
###