class CriticsController < ApplicationController
  def index
    @critics = @criticable.critics
    @name = @criticable.class.name.downcase
    @critic = Critic.new
  end

  def create
    @critic = @criticable.critics.new(critics_params)

    if @critic.save
      redirect_to [@criticable, :critics], status: :see_other
    else
      redirect_to [@criticable, :critics], status: :unprocessable_entity
    end
  end

  def destroy
    @critics = @criticable.critics.find(params[:id])
    @critics.destroy

    redirect_to [@criticable, :critics], status: :see_other
  end

  private

  def critics_params
    params.require(:critic).permit(:title, :body)
  end
end
