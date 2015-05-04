class CompetitionsController < ApplicationController
  before_action :authenticate_user!, only:
    [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_owner!, only: [:edit, :update, :destroy]

  def index
    @competitions = Competition.order(start_date: :desc)
  end

  def show
    @competition = Competition.includes(
      :rounds, :routes, :attempts).find(params[:id])
  end

  def new
    @competition = Competition.new
    @states = Competition::STATES
  end

  def create
    @competition = current_user.competitions.new(competition_params)
    @states = Competition::STATES

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
    @states = Competition::STATES
  end

  def update
    @competition = Competition.find(params[:id])
    @states = Competition::STATES

    if @competition.update(competition_params)
      flash[:notice] = 'Competition updated'
      redirect_to competition_path(@competition)
    else
      flash[:alert] = @competition.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @competition = Competition.find(params[:id])

    if @competition.destroy
      flash[:alert] = "Competition deleted"
      redirect_to competitions_path
    else
      flash[:alert] = @competition.errors.full_messages.join(". ")
      render :show
    end
  end

  protected

  def owner
    Competition.find(params[:id]).user
  end

  def competition_params
    params.require(:competition).permit(
      :name, :gender, :division, :start_date, :end_date, :gym, :city, :state)
  end
end
