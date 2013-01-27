require "uri" 
require "net/http" 
class OPortfolioApi
  
  if Rails.env.production?
    @@api_server = "http://o-portfolio-api-2.herokuapp.com"
  else
    @@api_server = "http://localhost:5000"
  end
  cattr_reader :api_server
    
  class << self
    
    ###################
    ## Session Stuff ##
    ###################
    def authenticate(credentials)
      uri = URI("#{self.api_server}/authenticate")

      req = Net::HTTP::Get.new(uri.request_uri)
      req.basic_auth credentials[:username], credentials[:password]
    
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: false) do |http|
        http.request(req)
      end
      
      p(res.body) and return nil unless res.code == "200"
      parse_json(res.body)
    end
    
    def create_user(details)
    
      uri = URI("#{self.api_server}/users/")

      req = Net::HTTP::Post.new(uri.request_uri)
      req.basic_auth details[:username], details[:password]
      req.set_form_data(details)
    
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: false) do |http|
        http.request(req)
      end
      
      p(res.body) and return nil unless res.code == "200"
      parse_json(res.body)
    end
    
    def get_user(credentials, user_id)
    
      uri = URI("#{self.api_server}/users/#{user_id}")

      req = Net::HTTP::Get.new(uri.request_uri)
      req.basic_auth credentials[:username], credentials[:password]
    
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: false) do |http|
        http.request(req)
      end
      
      p(res.body) and return nil unless res.code == "200"
      parse_json(res.body)
    end
    
    def update_user(credentials, user_id, details)
    
      uri = URI("#{self.api_server}/users/#{user_id}/")

      req = Net::HTTP::Put.new(uri.request_uri)
      req.basic_auth credentials[:username], credentials[:password]
      req.set_form_data(details)
    
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: false) do |http|
        http.request(req)
      end
      
      p(res.body) and return nil unless res.code == "200"
      parse_json(res.body)
    end
    
    ###################
    ## Entries Stuff ##
    ###################
    def get_entries(credentials)
    
      uri = URI("#{self.api_server}/entries/")

      req = Net::HTTP::Get.new(uri.request_uri)
      req.basic_auth credentials[:username], credentials[:password]
    
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: false) do |http|
        http.request(req)
      end
    
      p(res.body) and return nil unless res.code == "200"
      parse_json(res.body)
    end
    
    def get_entry(credentials, entry_id)
    
      uri = URI("#{self.api_server}/entries/#{entry_id}/")

      req = Net::HTTP::Get.new(uri.request_uri)
      req.basic_auth credentials[:username], credentials[:password]
    
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: false) do |http|
        http.request(req)
      end
    
      p(res.body) and return nil unless res.code == "200"
      parse_json(res.body)
    end
    
    def create_entry(credentials, details)
    
      uri = URI("#{self.api_server}/entries/")

      req = Net::HTTP::Post.new(uri.request_uri)
      req.basic_auth credentials[:username], credentials[:password]
      req.set_form_data(details)
      
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: false) {|http| http.request(req) }
      
      p(res.body) and return nil unless res.code == "200"
      parse_json(res.body)
    end
    
    def update_entry(credentials, entry_id, details)
    
      uri = URI("#{self.api_server}/entries/#{entry_id}/")

      req = Net::HTTP::Put.new(uri.request_uri)
      req.basic_auth credentials[:username], credentials[:password]
      req.set_form_data(details)
    
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: false) do |http|
        http.request(req)
      end
      
      p(res.body) and return nil unless res.code == "200"
      parse_json(res.body)
    end
    
    private
    
      def parse_json(json)
        dateify_dates(JSON.parse(json, symbolize_names: true))
      end
    
      def dateify_dates(data)      
        return data.map {|datum| dateify_dates(datum) } if data.is_a?(Array)

        data[:occurred_at] = DateTime.parse(data[:occurred_at]) if data[:occurred_at]
        data[:created_at] = DateTime.parse(data[:created_at]) if data[:created_at]
        data
      end
    end
end