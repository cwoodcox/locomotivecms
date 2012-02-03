require 'spec_helper'

describe Locomotive.config do
  describe "#enable_admin_ssl" do
    before :each do
      FactoryGirl.create("test site")
    end

    it "should redirect to SSL on admin when enabled" do
      Locomotive.config.enable_admin_ssl = true

      get 'http://test.example.com/admin'
      response.status.should == 301
      response.location.should =~ /https/
    end

    it "should redirect to correct SSL domain" do
      Locomotive.config.enable_admin_ssl = true
      Locomotive.config.secure_domain = "secure.example.com"

      get 'http://test.example.com/admin'
      response.status.should == 301
      response.location.should =~ /https\:\/\/secure\.example\.com/
    end

    it "should force multi_sites if secure_domain is set" do
      Locomotive.config.enable_admin_ssl = true
      Locomotive.config.secure_domain = "something.example.com"
      Locomotive.config.multi_sites.should == true
    end
  end
end