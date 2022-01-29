class CriticsController < ApplicationController
  def create
    @critics = @criticable.critics.new(critics_params)
  end

  # def create
  #   if params[:game_id]
  #     @game = Game.find(params[:game_id])
  #     @critic = @game.critics.create(critic_params)
  #     redirect_to game_path(@game)
  #   elsif params[:company_id]
  #     @company = Company.find(params[:company_id])
  #     @critic = @company.critics.create(critic_params)
  #     redirect_to company_path(@company)
  #   end
  # end

  def destroy
    @critics = @criticable.critics.new(critics_params)
    @critics.destroy

    redirect_to @criticable, status: :see_other
  end

  private

  def critics_params
    params.require(:critics).permit(:title, :body)
  end
end
