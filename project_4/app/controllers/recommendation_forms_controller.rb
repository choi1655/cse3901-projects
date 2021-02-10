class RecommendationFormsController < ApplicationController
  before_action :set_recommendation_form, only: [:show, :edit, :update, :destroy]
  before_action :is_instructor
  $studentid = ""

  # GET /recommendation_forms
  # GET /recommendation_forms.json
  def index
    @recommendation_forms = RecommendationForm.all
  end

  # GET /recommendation_forms/1
  # GET /recommendation_forms/1.json
  def show
  end

  # GET /recommendation_forms/new
  def new
    @recommendation_form = RecommendationForm.new
    $studentid = params[:username]
  end

  # GET /recommendation_forms/1/edit
  def edit
  end

  # POST /recommendation_forms
  # POST /recommendation_forms.json
  def create
    @recommendation_form = RecommendationForm.new(recommendation_form_params)
    @recommendation_form.instructor_id = current_user.username
    @recommendation_form.application_id = $studentid

    respond_to do |format|
      if @recommendation_form.save
        format.html { redirect_to @recommendation_form, notice: 'Recommendation form was successfully created.' }
        format.json { render :show, status: :created, location: @recommendation_form }
      else
        format.html { render :new }
        format.json { render json: @recommendation_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recommendation_forms/1
  # PATCH/PUT /recommendation_forms/1.json
  def update
    respond_to do |format|
      if @recommendation_form.update(recommendation_form_params)
        format.html { redirect_to @recommendation_form, notice: 'Recommendation form was successfully updated.' }
        format.json { render :show, status: :ok, location: @recommendation_form }
      else
        format.html { render :edit }
        format.json { render json: @recommendation_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommendation_forms/1
  # DELETE /recommendation_forms/1.json
  def destroy
    @recommendation_form.destroy
    respond_to do |format|
      format.html { redirect_to recommendation_forms_url, notice: 'Recommendation form was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recommendation_form
      @recommendation_form = RecommendationForm.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recommendation_form_params
      params.require(:recommendation_form).permit(:content, :username)
    end
end
