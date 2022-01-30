class InvolvedCompaniesController < ApplicationController
  before_action :set_game

  # POST /games/:game_id/companies
  def create
    @involved_company = authorize InvolvedCompany.new(involved_company_params)

    if @involved_company.save
      redirect_to @game, status: :see_other
    else
      redirect_to @game, status: :unprocessable_entity
    end
  end

  # DELETE /games/:game_id/companies/:company_id
  def destroy
    @involved_company = authorize @game.involved_companies.find_by(company_id: params[:company_id])
    @involved_company.destroy

    redirect_to @game, status: :see_other
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  # Only allow a list of trusted parameters through.
  def involved_company_params
    params.permit(:company_id, :game_id, :developer, :publisher)
  end
end
