class PositiveMessagesController < BaseController
  def new
    @positive_message = PositiveMessage.new
  end
end
