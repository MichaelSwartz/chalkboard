class AttemptsController < ApplicationController
  before_action :authenticate_user!, only:
    [:create, :edit, :update, :destroy]
  before_action :authenticate_owner!, only:
    [:create, :edit, :update, :destroy]

  def index
    @route = Route.includes(:attempts, :round).find(params[:route_id])
  end

  def create
    @route = Route.find(params[:route_id])
    @attempt = @route.attempts.new(attempt_params)

    if @attempt.save
      flash[:notice] = 'Attempt recorded'
      redirect_to route_path(@route)
    else
      flash[:alert] = @attempt.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
    @attempt = Attempt.find(params[:id])
  end

  def update
    @attempt = Attempt.find(params[:id])

    if @attempt.update(attempt_params)
      flash[:notice] = 'Attempt updated'
      redirect_to route_attempts_path(@attempt.route)
    else
      flash[:alert] = @attempt.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @attempt = Attempt.find(params[:id])

    if @attempt.destroy
      flash[:alert] = "Attempt deleted"
      redirect_to route_attempts_path(@attempt.route)
    else
      flash[:alert] = @attempt.errors.full_messages.join(". ")
      render :edit
    end
  end

  protected

  def owner
    if params[:route_id]
      Route.find(params[:route_id]).round.competition.user
    else
      Attempt.find(params[:id]).route.round.competition.user
    end
  end

  def attempt_params
    params.require(:attempt).permit(
      :athlete_id, :score)
  end
end
