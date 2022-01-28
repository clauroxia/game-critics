module Companies
  class CriticsController < CriticsController
    before_action set_criticable

    private

    def set_criticable
      @criticable = Game.find(params[:game_id])
    end
  end
end
