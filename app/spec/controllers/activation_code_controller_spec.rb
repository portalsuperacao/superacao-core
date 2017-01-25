require "rails_helper"

describe ActivationCodeController, :type => :controller do

  include AuthHelper
  before(:each) do
    jwt_authentication
  end

  it "should authenticate user with valid activation code" do
    overcomer = create(:overcomer)

    request.env['HTTP_AUTHORIZATION'] = @HTTP_AUTHORIZATION
    post :activate,
         params: {code: overcomer.activation_code.code}

    expect(response.status).to eq(200)
    expect(overcomer.reload.activation_code.activated).to be true
  end

  it "should NOT authenticate user with invalid credentials" do
    overcomer = create(:overcomer)

    request.env['HTTP_AUTHORIZATION'] = 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.EkN-DOsnsuRjRO6BxXemmJDm3HbxrbRzXglbN2S4sOkopdU4IsDxTI8jO19W_A4K8ZPJijNLis4EZsHeY559a4DFOd50_OqgHGuERTqYZyuhtF39yxJPAjUESwxk2J5k_4zM3O-vtd1Ghyo4IbqKKSy6J9mTniYJPenn5-HIirE'
    post :activate,
         params: {code: overcomer.activation_code.code}

    expect(response.status).to eq(401)
  end

  it "should NOT authenticate user which already activated code" do
    overcomer = create(:overcomer)
    overcomer.activation_code.activated = true
    overcomer.activation_code.activated_at = Date.today
    overcomer.activation_code.save

    request.env['HTTP_AUTHORIZATION'] = @HTTP_AUTHORIZATION
    post :activate,
         params: {code: overcomer.activation_code.code }

    expect(response.status).to eq(422)
  end

  it "should return 404 for inexistent activation code" do
    request.env['HTTP_AUTHORIZATION'] = @HTTP_AUTHORIZATION
    post :activate,
         params: { code: "@IMPOSSIBLE_CODE@" }

    expect(response.status).to eq(404)
  end

end
