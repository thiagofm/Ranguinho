require 'spec_helper'

describe PlacesController do
  context '#signed in' do
    let(:user) { FactoryGirl.create :user, completed: true }
    let(:profile) { FactoryGirl.create(:profile, user: user) }

    before(:each) do
      sign_in user
    end

    context '#index' do
      before(:each) do
        #TODO: ask on SO why do I have to call user and profile...
        user
        profile
        get :index
      end

      it 'should have places' do
        assigns(:places).should_not == nil
      end

      context '#filter' do
        it 'should have a default distance' do
          assigns(:maximum_distance).should == 5
        end

        it 'should receive a distance to be filtered and get it assigned' do
          get :index, {'/places' => {'maximum_distance' => 7} }
          assigns(:maximum_distance).should == "7"
        end

        it 'finds places close to it' do
          pending 'refactor'
        end

        it 'sets up markers for gmaps' do
          pending 'refactor'
        end
      end
    end

    context '#show' do
      before(:each) do
        get :show, id: FactoryGirl.create(:place, user: user)
      end

      it 'should be reachable' do
        response.status.should == 200
      end

      it 'should have a place' do
        assigns(:place).should_not == nil
      end

      it 'should have opinions' do
        assigns(:opinions).should_not == nil
      end

      it 'should have opinion' do
        assigns(:opinion).should_not == nil
      end
    end

    context '#new' do
      it 'should be reachable' do
        get :new
        response.status.should == 200
      end

      it 'should instantiate a new place' do
        get :new
        assigns(:place).should be_an_instance_of Place
      end
    end

    context '#create' do
      it 'should redirect to place after created' do
        post :create, { place: FactoryGirl.attributes_for(:place) }

        response.should redirect_to place_path(assigns(:place))
      end

      it 'should show the form again if errors are raised' do
        place = mock_model(Place).as_null_object

        place.stub!(:save).and_return(false)
        post :create

        response.should render_template('new')
      end
    end
  end
end
