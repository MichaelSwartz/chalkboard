class RoundsController < ApplicationController
  before_action :authenticate_user!, only:
    [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_owner!, only:
    [:new, :create, :edit, :update, :destroy]

  def show
    @round = Round.includes(:routes, :attempts).find(params[:id])
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
    @round = Round.find(params[:id])
  end

  def update
    @round = Round.find(params[:id])

    if @round.update(round_params)
      flash[:notice] = 'Round updated'
      redirect_to round_path(@round)
    else
      flash[:alert] = @round.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @round = Round.find(params[:id])

    if @round.destroy
      flash[:alert] = "Round deleted"
      redirect_to competition_path(@round.competition)
    else
      flash[:alert] = @round.errors.full_messages.join(". ")
      render :show
    end
  end

  protected

  def owner
    if params[:competition_id]
      Competition.find(params[:competition_id]).user
    else
      Round.find(params[:id]).competition.user
    end
  end

  def round_params
    params.require(:round).permit(
      :name, :number, :competition_id)
  end
end
