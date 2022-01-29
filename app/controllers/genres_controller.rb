class GenresController < ApplicationController
  before_action :set_game

  # POST /games/:game_id/genres
  def create
    @genre = Genre.find(params[:genre_id])
    @game.genres << @genre

    redirect_to @game, status: :see_other
  end

  # DELETE /games/:game_id/genres/:id
  def destroy
    @genre = @game.genres.find(params[:id])
    @game.genres.delete(@genre)

    redirect_to @game, status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:game_id])
  end

  # Only allow a list of trusted parameters through.
  def genre_params
    params.require(:genre).permit(:name)
  end
end
