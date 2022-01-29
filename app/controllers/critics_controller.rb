class CriticsController < ApplicationController
  def create
    @critics = @criticable.critics.new(critics_params)
  end

  def destroy
    @critics = @criticable.critics.new(critics_params)
    @critics.destroy

    redirect_to @criticable, status: :see_other
  end

  private

  def critics_params
    params.require(:critic).permit(:title, :body)
  end
end
