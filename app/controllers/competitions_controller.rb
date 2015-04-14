class CompetitionsController < ApplicationController
  before_action :authenticate_user!, only:
    [:new, :create, :edit, :update, :destroy]

    STATES = ['AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA',
      'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI',
      'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY',
      'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VT',
      'WA', 'WI', 'WV', 'WY']

  def index
    @competitions = Competition.order(start_date: :desc)
  end

  def show
    @competition = Competition.find(params[:id])
  end

  def new
    @competition = Competition.new
    @STATES = STATES
  end

  def create
    @competition = current_user.competitions.new(competition_params)
    @STATES = STATES

    if @competition.save
      flash[:notice] = 'New competition created'
      redirect_to competition_path(@competition)
    else
      flash[:alert] = @competition.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
    @competition = Competition.find(params[:id])
    @STATES = STATES
  end

  def update
    @competition = Competition.find(params[:id])
    @STATES = STATES

    if @competition.update(competition_params)
      flash[:notice] = 'Competition updated'
      redirect_to competition_path(@competition)
    else
      flash[:alert] = @competition.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @competition = competition.find(params[:id])

    if @competition.destroy
      flash[:alert] = "Competition deleted"
      redirect_to competitions_path
    else
      flash[:alert] = @competition.errors.full_messages.join(". ")
      render :show
    end
  end

  protected

  def competition_params
    params.require(:competition).permit(
      :name, :gender, :division, :start_date, :end_date, :gym, :city, :state)
  end
end
