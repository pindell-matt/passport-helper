require 'rails_helper'

describe PassportsController do

  it "assigns active_passports" do
    active_passports = Passport.active_passports
    get :index
    expect(assigns(:active_passports)).to eq(active_passports)
  end

  it "assigns inactive_passports" do
    inactive_passports = Passport.inactive_passports
    get :index
    expect(assigns(:inactive_passports)).to eq(inactive_passports)
  end

  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end

end
