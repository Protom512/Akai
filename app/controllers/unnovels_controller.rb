# frozen_string_literal: true

class UnnovelsController < ApplicationController
  before_action :set_unnovel, only: %i[show edit update destroy]

  # GET /unnovels
  def index
    @updates = Update.all.order(:novel_created_at).last(10).order(:novel_updated_at).group(:ncode)
    @update_data = Update.daily_data
    gon.json_url = unnovels_url + '.json'

    gon.update_avg = Update.avg_daily_count

    respond_to do |format|
      format.html
      format.json { render json: @update_data.to_json }
    end
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
