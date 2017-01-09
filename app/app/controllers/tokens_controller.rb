class TokensController < BaseController
  def firebase_token
    # render plain: "ok"
    render template: "tmp/firebase_token.html.erb"
  end
end
