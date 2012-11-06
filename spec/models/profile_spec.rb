require 'spec_helper'

describe Profile do
  context "#factory" do
    let(:user) { FactoryGirl.create(:user) }

    context '#address' do
      it "should raise a error if the country doesn't exist" do
        lambda { FactoryGirl.create(:profile, user: user, country: 'Pokemon World') }.should raise_error
      end

      it "should raise a error if the state in the country doesn't exist" do
        lambda { FactoryGirl.create(:profile, user: user, country: 'BR', state: 'New York') }.should raise_error
      end

      it "should allow street to be empty" do
        FactoryGirl.create(:profile, user: user, street: '').should be_valid
      end
    end

    context '#name' do
      it "should have one" do
        lambda { FactoryGirl.create(:profile, user: user, name: '') }.should raise_error
      end
    end
  end
end
