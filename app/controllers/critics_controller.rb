class CriticsController < ApplicationController
  def index
    @critics = @criticable.critics
    @name = @criticable.class.name.downcase
    @critic = Critic.new
  end

  def create
    @critics = @criticable.critics.scope
    @name = @criticable.class.name.downcase
    @critic = @criticable.critics.new(critics_params)
    @critic.user_id = current_user.id
    @critic.approved = true if @critic.user.admin?

    if @critic.save
      redirect_to [@criticable, :critics], status: :see_other
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @critic = authorize @criticable.critics.find(params[:id])
    @critic.destroy

    redirect_to [@criticable, :critics], status: :see_other
  end

  def update
    @critic = authorize @criticable.critics.find(params[:id])
    @critic.approved = true
    @critic.save

    redirect_to [@criticable, :critics], status: :see_other
  end

  private

  def critics_params
    params.require(:critic).permit(:title, :body)
  end
end
