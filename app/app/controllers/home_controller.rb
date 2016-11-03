class HomeController < BaseController

  before_action :authenticate_user!

  def index

  end
end
