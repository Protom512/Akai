class UnnovelsController < ApplicationController
  before_action :set_unnovel, only: [:show, :edit, :update, :destroy]

  # GET /unnovels
  def index

    @unnovels = Unnovel.all
    @users = User.all
  end

  # GET /unnovels/1
  def show
  end

  # GET /unnovels/new
  # def new
  #   @unnovel = Unnovel.new
  # end

  # GET /unnovels/1/edit
  def edit
  end

  # POST /unnovels
  def create
    @unnovel = Unnovel.new(unnovel_params)

    if @unnovel.save
      redirect_to @unnovel, notice: 'Unnovel was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /unnovels/1
  def update
    if @unnovel.update(unnovel_params)
      redirect_to @unnovel, notice: 'Unnovel was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /unnovels/1
  # def destroy
  #   @unnovel.destroy
  #   redirect_to unnovels_url, notice: 'Unnovel was successfully destroyed.'
  # end

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
