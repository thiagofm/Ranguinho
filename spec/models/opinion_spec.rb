require 'spec_helper'

describe Opinion do
  context "#factory" do
    let(:user) { FactoryGirl.create(:user) }
    let(:place) { FactoryGirl.create(:place, user: user) }

    it "should have a valid factory" do
      FactoryGirl.create(:opinion, user: user, place: place).should be_valid
    end

    it "should rate a place" do
      lambda { FactoryGirl.create(:opinion, user: user, place: place, rate: nil) }.should raise_error
    end

    it "should have a user" do
      lambda { FactoryGirl.create(:opinion, place: place) }.should raise_error
    end 

    it "should have a place" do
      lambda { FactoryGirl.create(:opinion, user: user) }.should raise_error
    end
  end
end
