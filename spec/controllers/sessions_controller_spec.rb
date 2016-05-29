require 'rails_helper'

describe SessionsController, "using omni auth" do
  it "creates or finds user from auth hash and redirects to home" do
    set_omniauth
    post :create, provider: :facebook
    expect(response).to redirect_to root_path
    expect(session[:user_id]).to_not be_nil
  end

  it "invalid credentials test" do
    post :create, provider: :facebook
    expect(flash[:warning]).to be_present
    expect(response).to redirect_to root_path
  end

  describe "sessions#destroy" do

    before do
      set_omniauth
      post :create, provider: :facebook
    end

    it "destroys a sessions" do
      expect(session[:user_id]).to_not be_nil
      get :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to root_path
    end

  end
end

describe SessionsController, "using email" do

  before do
    create_users(1)
    @user = User.first
  end

  it "logs user in succssfully" do
    expect(session[:user_id]).to be_nil
    post :create_from_email, session: {email: @user.email, password: "password"}
    expect(session[:user_id]).to_not be_nil
    expect(response).to redirect_to user_dashboard_path
  end

  it "does not log in due to invalid password" do
    expect(session[:user_id]).to be_nil
    post :create_from_email, session: {email: @user.email, password: "pass"}
    expect(session[:user_id]).to be_nil
    expect(response).to render_template :new
    expect(flash[:warning]).to be_present
  end

  it "does not log in due to invalid email" do
    expect(session[:user_id]).to be_nil
    post :create_from_email, session: {email: "mark@markmiranda.ninja", password: "password"}
    expect(session[:user_id]).to be_nil
    expect(response).to render_template :new
    expect(flash[:warning]).to be_present
  end
end