require 'spec_helper'

describe ProfilesController do
  let(:user) { FactoryGirl.create :user, completed: true }
  let(:profile) { FactoryGirl.create(:profile, user: user) }

  context '#show' do
    it 'should show the requested user profile' do
      profile
      get :show, username: user.username
      assigns(:profile).should == profile
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
    context '#signed in' do
      before(:each) do
        sign_in(user)
      end

      it 'should redirect to the user profile upon save' do
        post :create, user_id: user.id, profile: FactoryGirl.attributes_for(:profile)

        response.should redirect_to places_path
      end

      it 'should show the form again if errors are raised' do
        place = mock_model(Profile)

        place.stub!(:save).and_return(false)
        post :create, user_id: user.id

        response.should render_template('new')
      end

      it 'should be accessible only if user doesn\'t have a profile' do
        profile
        post :create, user_id: user.id
        response.status.should_not == 200
      end
    end

    it 'shouldn\'t be accessible if user isnt logged in' do
      post :create, user_id: user.id
    end
  end

  context '#edit' do
    context 'signed in' do
      before(:each) do
        sign_in(user)
      end

      it 'should assign the current user as the profile being edited' do
        profile
        get :edit, user_id: user.profile.id, id: user.id
        assigns(:profile).should == user.profile
      end
    end
  end

  context '#update' do
    context 'signed in' do
      before(:each) do
        sign_in(user)
      end

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

    it 'shouldn\'t be accessible if user isnt logged in' do
      user
      profile
      put :update, user_id: user.profile.id, id: user.id
    end
  end
end
