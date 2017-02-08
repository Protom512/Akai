class UnnovelsController < ApplicationController
  before_action :set_unnovel, only: [:show, :edit, :update, :destroy]

  # GET /unnovels
  def index
    @updates = Update.all.order(:novel_updated_at).group(:ncode).last(10)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unnovel
      @unnovel = Unnovel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def unnovel_params
      params.fetch(:unnovel, {})
    end
end
