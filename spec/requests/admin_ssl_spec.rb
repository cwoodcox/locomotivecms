require 'spec_helper'

describe Locomotive.config do
  describe "#enable_admin_ssl" do
    before :each do
      FactoryGirl.create("existing site")
      FactoryGirl.create(:account)
    end

    it "should redirect to SSL on admin when enabled" do
      Locomotive.config.enable_admin_ssl = true

      get '/admin'
      response.status.should == 301
      response.location.should =~ /https/
    end

    it "should not redirect to SSL on admin when disabled" do
      Locomotive.config.enable_admin_ssl = false

      get '/admin'
      response.status.should == 301
      response.location.should =~ /http/
    end    
  end
end