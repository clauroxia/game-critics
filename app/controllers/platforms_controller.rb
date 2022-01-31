class PlatformsController < ApplicationController
  before_action :set_game

  # POST /games/:game_id/platforms
  def create
    @platform = authorize Platform.find(params[:platform_id])
    @game.platforms << @platform

    redirect_to @game, status: :see_other
  end

  # DELETE /games/:game_id/platforms/:id
  def destroy
    @platform = authorize @game.platforms.find(params[:id])
    @game.platforms.delete(@platform)

    redirect_to @game, status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:game_id])
  end

  # Only allow a list of trusted parameters through.
  def platform_params
    params.require(:platform).permit(:name, :category)
  end
end
