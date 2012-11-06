require 'spec_helper'

describe User do
  context '#factory' do
    it "should have a valid factory" do
      FactoryGirl.create(:user).should be_valid
    end

    it "should have a password larger than 6 characters" do
      lambda { FactoryGirl.create(:user, password: '12345') }.should raise_error
    end

    it "shouldn't accept e-mail in the wrong format" do
      lambda { FactoryGirl.create(:user, email: '12345') }.should raise_error 
    end

    it "shouldn't accept username with weird characters" do
      lambda { FactoryGirl.create(:user, username: ':D:D') }.should raise_error 
    end
  end
end
