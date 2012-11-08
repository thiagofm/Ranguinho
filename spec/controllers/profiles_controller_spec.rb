require 'spec_helper'

describe ProfilesController do
  let(:user) { FactoryGirl.create :user, completed: true }
  let(:profile) { FactoryGirl.create(:profile, user: user) }

  context '#index' do
    it 'should show 404' do
      pending
    end
  end

  context '#show' do
    it 'should show the requested user profile' do
      get :show, username: user.username
      response.status.should == 200
    end
  end

  context '#new' do
    context '#signed in' do
      before(:each) do
        sign_in(user)
      end

      it 'should assign a profile' do
        get :new, user_id: user.id
        assigns(:profile).should_not == nil
      end

      it 'should be accessible only if user doesn\'t have a profile' do
        profile
        get :new, user_id: user.id
        response.status.should_not == 200
      end
    end

    it 'shouldn\'t be accessible if user isnt logged in' do
      get :new, user_id: user.id
    end
  end

  context '#create' do
    it 'should redirect to the user profile upon save' do
      pending
    end

    it 'should show the form again if errors are raised' do
      pending
    end

    it 'should be accessible only if user doesn\'t have a profile' do
      pending
    end
  end

  context '#edit' do
    it 'should assign the current user as the profile being edited' do
      pending
    end
  end

  context '#update' do
    it 'should set gmaps of user to false in order to his address get updated' do
      pending
    end

    it 'should redirect to the user profile on save' do
      pending
    end

    it 'should show the form again if errors are raised' do
      pending
    end
  end
end
