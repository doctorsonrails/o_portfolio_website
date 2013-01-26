require 'spec_helper'

describe OPortfolioApi do
  
  before :each do
    @credentials = {username: "admin@nhs.com", password: "test"}
  end
  
  describe "login" do
    it "should login with only the correct credentials" do
      OPortfolioApi.login(@credentials[:username], @credentials[:password]).should be_true
      OPortfolioApi.login("#{@credentials[:username]}#{rand}", "#{@credentials[:username]}").should be_false
      OPortfolioApi.login("#{@credentials[:username]}", "#{@credentials[:username]}#{rand}").should be_false
    end
  end
  describe "register_user" do
    it "should create and return a user with correct credentials" do
      OPortfolioApi.register_user(first_name: "Jeremy", last_name: "Walker", email: "jez.walker@gmail.com2", password: "foobar").should == "WHAT AM I?"
    end
  end
  
  describe "get_entries" do
    it "should return a user's entries" do
      entries = OPortfolioApi.get_entries(@credentials[:username], @credentials[:password])
      entries.should be_a Array
      entries[0].should be_a Hash
    end
  end
  describe "get_entry" do
    it "should return an entry" do
      entries = OPortfolioApi.get_entries(@credentials[:username], @credentials[:password])
      OPortfolioApi.get_entry(@credentials[:username], @credentials[:password], entries.first['id']).should == "WHAT AM I?"
    end
  end
  describe "create_entry" do
    it "should create and return an entry" do
      pending "Stop spamming Ed"
      
      details = {
        title: "Foobar",
        description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        occurred_at: DateTime.yesterday,
        reflection: "This was great"
      }
      json = OPortfolioApi.create_entry(@credentials[:username], @credentials[:password], details)
      json.keys.should include "id"
      json.keys.should include "created_at"
      json['title'].should == details[:title]
      json['description'].should == details[:description]
      json['occurred_at'].should == "#{details[:occurred_at].to_date.to_s}T00:00:00"
      json['reflection'].should == details[:reflection]
    end
  end
end