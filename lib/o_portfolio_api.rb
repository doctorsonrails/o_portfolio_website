require "uri" 
require "net/http" 
class OPortfolioApi
  
  class << self
    
    ###################
    ## Session Stuff ##
    ###################
    def login(username, password)
    
      uri = URI('https://o-portfolio-api.herokuapp.com/entries/')

      req = Net::HTTP::Get.new(uri.request_uri)
      req.basic_auth username, password
    
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
    
      res.code == "200"
    end
    
    def register_user(details)
    
      uri = URI('https://o-portfolio-api.herokuapp.com/users/')

      req = Net::HTTP::Post.new(uri.request_uri)
      req.basic_auth details[:email], details[:password]
      req.set_form_data(details)
    
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
      
      JSON.load(res.body)
    end
    
    ###################
    ## Entries Stuff ##
    ###################
    def get_entries(username, password)
    
      uri = URI('https://o-portfolio-api.herokuapp.com/entries/')

      req = Net::HTTP::Get.new(uri.request_uri)
      req.basic_auth username, password
    
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
    
      JSON.load(res.body)
    end
    
    def get_entry(username, password, entry_id)
    
      uri = URI("https://o-portfolio-api.herokuapp.com/entries/#{entry_id}")

      req = Net::HTTP::Get.new(uri.request_uri)
      req.basic_auth username, password
    
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
    
      JSON.load(res.body)
    end
    
    def create_entry(username, password, details)
    
      uri = URI('https://o-portfolio-api.herokuapp.com/entries/')

      req = Net::HTTP::Post.new(uri.request_uri)
      req.basic_auth username, password
      req.set_form_data(details)
      
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) {|http| http.request(req) }
      JSON.load(res.body)
    end
  end
end