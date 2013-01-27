require 'spec_helper'

describe OPortfolioApi do
  
  before :each do
    @credentials = {username: "admin@nhs.com", password: "test"}
  end
  
  describe "user_management" do
    
    it "should create, edit, get and authenticate as a user" do
      first_name = "The#{rand}"
      last_name  = "Man#{rand}"
      email      = "foobar#{rand}@foobar.com"
      password   = "foobar#{rand}"
      
      json = OPortfolioApi.create_user(first_name: first_name, last_name: last_name, email: email, password: password)
      json.keys.should include :id
      json[:first_name].should == first_name
      json[:last_name].should  == last_name
      json[:email].should      == email
      
      id = json[:id]
      
      credentials = {username: email, password: password}
      
      json = OPortfolioApi.get_user(credentials, id)
      json.keys.should include :id
      json[:first_name].should == first_name
      json[:last_name].should  == last_name
      json[:email].should      == email
      
      OPortfolioApi.authenticate(credentials)[:id].should == id
      OPortfolioApi.authenticate({username: "#{email}#{rand}", password: password}).should be_nil
      OPortfolioApi.authenticate({username: email, password: "#{password}#{rand}"}).should be_nil
      
      new_first_name = "Ed#{rand}"
      new_last_name  = "Wallitt#{rand}"
      new_email      = "Foobar#{rand}123@foobar.com"
      
      json = OPortfolioApi.update_user(credentials, 1, first_name: new_first_name, last_name: new_last_name, email: new_email, password: "foobar")
      json.keys.should include :id
      json[:first_name].should == new_first_name
      json[:last_name].should  == new_last_name
      json[:email].should      == new_email
    end
    
  end
  
  it "should create, get, update and delete an entry" do
  
    details = {
      title: "Foobar",
      description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      occurred_at: DateTime.yesterday,
      reflection: "This was great"
    }
    json = OPortfolioApi.create_entry(@credentials, details)
    json.keys.should include :id
    json.keys.should include :created_at
    json[:title].should       == details[:title]
    json[:description].should == details[:description]
    json[:occurred_at].should == "#{details[:occurred_at].to_date.to_s}T00:00:00"
    json[:reflection].should  == details[:reflection]
  
    id = json[:id]
  
    json = OPortfolioApi.get_entry(@credentials, id)
    json[:title].should       == details[:title]
    json[:description].should == details[:description]
    json[:occurred_at].should == "#{details[:occurred_at].to_date.to_s}T00:00:00"
    json[:reflection].should  == details[:reflection]
    
    json = OPortfolioApi.get_entries(@credentials)
    entry = json.select{|entry|entry[:id] == id}.first
    entry[:title].should       == details[:title]
    entry[:description].should == details[:description]
    entry[:occurred_at].should == "#{details[:occurred_at].to_date.to_s}T00:00:00"
    entry[:reflection].should  == details[:reflection]
    
    new_details = {title: "big foobar", description: "description foobar", reflection: "reflection foobar", occurred_at: DateTime.tomorrow}
    
    json = OPortfolioApi.update_entry(@credentials, id, new_details)
    json[:title].should       == new_details[:title]
    json[:description].should == new_details[:description]
    json[:occurred_at].should == "#{new_details[:occurred_at].to_date.to_s}T00:00:00"
    json[:reflection].should  == new_details[:reflection]
  end
end