class UserfeedbacksController < ApplicationController
  before_action :set_userfeedback, only: [:show, :edit, :update, :destroy]

  # GET /userfeedbacks
  # GET /userfeedbacks.json
  def index
    @userfeedbacks = Userfeedback.all
  end

  # GET /userfeedbacks/1
  # GET /userfeedbacks/1.json
  def show
  end

  # GET /userfeedbacks/new
  def new
    @userfeedback = Userfeedback.new
  end

  # GET /userfeedbacks/1/edit
  def edit
  end

  # POST /userfeedbacks
  # POST /userfeedbacks.json
  def create
    @userfeedback = Userfeedback.new(userfeedback_params)

    respond_to do |format|
      if @userfeedback.save
        format.html { redirect_to @userfeedback, notice: 'Userfeedback was successfully created.' }
        format.json { render :show, status: :created, location: @userfeedback }
      else
        format.html { render :new }
        format.json { render json: @userfeedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /userfeedbacks/1
  # PATCH/PUT /userfeedbacks/1.json
  def update
    respond_to do |format|
      if @userfeedback.update(userfeedback_params)
        format.html { redirect_to @userfeedback, notice: 'Userfeedback was successfully updated.' }
        format.json { render :show, status: :ok, location: @userfeedback }
      else
        format.html { render :edit }
        format.json { render json: @userfeedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /userfeedbacks/1
  # DELETE /userfeedbacks/1.json
  def destroy
    @userfeedback.destroy
    respond_to do |format|
      format.html { redirect_to userfeedbacks_url, notice: 'Userfeedback was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_userfeedback
      @userfeedback = Userfeedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def userfeedback_params
      params.require(:userfeedback).permit(:email, :feedback)
    end
end
