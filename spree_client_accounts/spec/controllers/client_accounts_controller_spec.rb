require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ClientAccountsController do

  # This should return the minimal set of attributes required to create a valid
  # ClientAccount. As you add validations to ClientAccount, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ClientAccountsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all client_accounts as @client_accounts" do
      client_account = ClientAccount.create! valid_attributes
      get :index, {}, valid_session
      assigns(:client_accounts).should eq([client_account])
    end
  end

  describe "GET show" do
    it "assigns the requested client_account as @client_account" do
      client_account = ClientAccount.create! valid_attributes
      get :show, {:id => client_account.to_param}, valid_session
      assigns(:client_account).should eq(client_account)
    end
  end

  describe "GET new" do
    it "assigns a new client_account as @client_account" do
      get :new, {}, valid_session
      assigns(:client_account).should be_a_new(ClientAccount)
    end
  end

  describe "GET edit" do
    it "assigns the requested client_account as @client_account" do
      client_account = ClientAccount.create! valid_attributes
      get :edit, {:id => client_account.to_param}, valid_session
      assigns(:client_account).should eq(client_account)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ClientAccount" do
        expect {
          post :create, {:client_account => valid_attributes}, valid_session
        }.to change(ClientAccount, :count).by(1)
      end

      it "assigns a newly created client_account as @client_account" do
        post :create, {:client_account => valid_attributes}, valid_session
        assigns(:client_account).should be_a(ClientAccount)
        assigns(:client_account).should be_persisted
      end

      it "redirects to the created client_account" do
        post :create, {:client_account => valid_attributes}, valid_session
        response.should redirect_to(ClientAccount.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved client_account as @client_account" do
        # Trigger the behavior that occurs when invalid params are submitted
        ClientAccount.any_instance.stub(:save).and_return(false)
        post :create, {:client_account => { "name" => "invalid value" }}, valid_session
        assigns(:client_account).should be_a_new(ClientAccount)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ClientAccount.any_instance.stub(:save).and_return(false)
        post :create, {:client_account => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested client_account" do
        client_account = ClientAccount.create! valid_attributes
        # Assuming there are no other client_accounts in the database, this
        # specifies that the ClientAccount created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ClientAccount.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => client_account.to_param, :client_account => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested client_account as @client_account" do
        client_account = ClientAccount.create! valid_attributes
        put :update, {:id => client_account.to_param, :client_account => valid_attributes}, valid_session
        assigns(:client_account).should eq(client_account)
      end

      it "redirects to the client_account" do
        client_account = ClientAccount.create! valid_attributes
        put :update, {:id => client_account.to_param, :client_account => valid_attributes}, valid_session
        response.should redirect_to(client_account)
      end
    end

    describe "with invalid params" do
      it "assigns the client_account as @client_account" do
        client_account = ClientAccount.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ClientAccount.any_instance.stub(:save).and_return(false)
        put :update, {:id => client_account.to_param, :client_account => { "name" => "invalid value" }}, valid_session
        assigns(:client_account).should eq(client_account)
      end

      it "re-renders the 'edit' template" do
        client_account = ClientAccount.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ClientAccount.any_instance.stub(:save).and_return(false)
        put :update, {:id => client_account.to_param, :client_account => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested client_account" do
      client_account = ClientAccount.create! valid_attributes
      expect {
        delete :destroy, {:id => client_account.to_param}, valid_session
      }.to change(ClientAccount, :count).by(-1)
    end

    it "redirects to the client_accounts list" do
      client_account = ClientAccount.create! valid_attributes
      delete :destroy, {:id => client_account.to_param}, valid_session
      response.should redirect_to(client_accounts_url)
    end
  end

end