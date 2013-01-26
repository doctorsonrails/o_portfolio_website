DS.RESTAdapter.configure "plurals",
  entry: "entries"

OPortfolioWebsite.Store = DS.Store.extend
  revision: 11,
  adapter: DS.RESTAdapter.create
      #url: "http://api.oportfol.io"
      #url: "http://e-portfolio-api.herokuapp.com"
      url: ""