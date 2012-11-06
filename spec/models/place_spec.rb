require 'spec_helper'

describe Place do
  context "#factory" do
    let(:user) { FactoryGirl.create(:user) }

    it "should have a valid factory" do
      FactoryGirl.create(:place, user: user).should be_valid
    end

    context '#address' do
      it "should raise a error if the country doesn't exist" do
        lambda { FactoryGirl.create(:place, user: user, country: 'Pokemon World') }.should raise_error
      end

      it "should raise a error if the state in the country doesn't exist" do
        lambda { FactoryGirl.create(:place, user: user, country: 'BR', state: 'New York') }.should raise_error
      end

      it "should allow street to be empty" do
        FactoryGirl.create(:place, user: user, street: '').should be_valid
      end
    end

    context '#title' do
      it "should not be BIG" do
        lambda { FactoryGirl.create(:place, title:"1418947104387104817840917341094710947109471089470947104") }.should raise_error
      end

      it "should not be very small" do
        lambda { FactoryGirl.create(:place, title:"a") }.should raise_error
      end
    end
  end
end
