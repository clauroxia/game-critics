class InvolvedCompaniesController < ApplicationController
  before_action :set_involved_company, only: %i[ show edit update destroy ]

  # GET /involved_companies
  def index
    @involved_companies = InvolvedCompany.all
  end

  # GET /involved_companies/1
  def show
  end

  # GET /involved_companies/new
  def new
    @involved_company = InvolvedCompany.new
  end

  # GET /involved_companies/1/edit
  def edit
  end

  # POST /involved_companies
  def create
    @involved_company = InvolvedCompany.new(involved_company_params)

    if @involved_company.save
      redirect_to @involved_company, notice: "Involved company was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /involved_companies/1
  def update
    if @involved_company.update(involved_company_params)
      redirect_to @involved_company, notice: "Involved company was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /involved_companies/1
  def destroy
    @involved_company.destroy
    redirect_to involved_companies_url, notice: "Involved company was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_involved_company
      @involved_company = InvolvedCompany.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def involved_company_params
      params.require(:involved_company).permit(:companies_id, :games_id, :developer, :publisher)
    end
end
