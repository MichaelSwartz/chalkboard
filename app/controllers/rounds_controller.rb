class RoundsController < ApplicationController
  before_action :authenticate_user!, only:
    [:new, :create, :edit, :update, :destroy]

  def index
    @competition = Competition.find(params[:competition_id])
    redirect_to competition_path(@competition)
  end

  def show
    @round = Round.find(params[:id])
    @competition = @round.competition
  end

  def new
    @competition = Competition.find(params[:competition_id])
    @round = Round.new
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @round = @competition.rounds.new(round_params)

    if @round.save
      flash[:notice] = 'New round created'
      redirect_to round_path(@round)
    else
      flash[:alert] = @round.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
    @round = round.find(params[:id])
  end

  def update
    @round = round.find(params[:id])

    if @round.update(round_params)
      flash[:notice] = 'Round updated'
      redirect_to round_path(@round)
    else
      flash[:alert] = @round.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @round = round.find(params[:id])
    @competition = @round.competition

    if @round.destroy
      flash[:alert] = "Round deleted"
      redirect_to competition_path(@competition)
    else
      flash[:alert] = @round.errors.full_messages.join(". ")
      render :show
    end
  end

  protected

  def round_params
    params.require(:round).permit(
      :name, :number, :competition_id)
  end
end
