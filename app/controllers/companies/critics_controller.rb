module Companies
  class CriticsController < CriticsController
    before_action :set_criticable

    private

    def set_criticable
      @criticable = Company.find(params[:company_id])
    end
  end
end
