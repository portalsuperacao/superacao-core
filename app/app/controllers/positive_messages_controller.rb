class PositiveMessagesController < BaseController
  before_filter :find_resource, only: [:show, :edit, :update, :destroy]

  # TODO: Authentication method for mobile app
  def index
    @positive_messages = PositiveMessage.all.page(params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @positive_messages}
    end
  end

  def new
    @positive_message = PositiveMessage.new
  end

  def create
    @positive_message = PositiveMessage.new(pm_params)

    if @positive_message.save
      flash[:success] = "Imagem positiva criada com sucesso."
      redirect_to positive_messages_path
    else
      flash[:error] = "Imagem positiva não foi criada."
      render :show
    end
  end

  def update
     if @positive_message.update(pm_params)
       flash[:success] = "Imagem positiva atualizada com sucesso."
       redirect_to @positive_message
     else
       flash[:error] = "Imagem positiva não foi atualizada."
       render :show
     end
  end

  def destroy
    if PositiveMessage.destroy(params[:id])
      render json: :success
    else
      render json: :error
    end
  end

  private
  def pm_params
    params.require(:positive_message).permit(:name, :category, :image)
  end

  def find_resource
    @positive_message = PositiveMessage.find(params[:id])
  end
end
