class AttemptsController < ApplicationController
  before_action :authenticate_user!, only:
    [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_owner_nested!, only:
    [:new, :create]
  before_action :authenticate_owner_un_nested!, only:
    [:edit, :update, :destroy]

  def index
    @route = Route.includes(:attempts, :round).find(params[:route_id])
  end

  def new
    @route = Route.includes(:round).find(params[:route_id])
    @attempt = Attempt.new
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

  def authenticate_owner_nested!
    @route = Route.find(params[:route_id])
    @competition = @route.round.competition

    unless @competition.user == current_user
      flash[:alert] = "Access restricted to competition creator"
      redirect_to route_path(@route)
    end
  end

  def authenticate_owner_un_nested!
    @route = Attempt.find(params[:id]).route
    @competition = @route.round.competition

    unless @competition.user == current_user
      flash[:alert] = "Access restricted to competition creator"
      redirect_to route_path(@route)
    end
  end

  def attempt_params
    params.require(:attempt).permit(
      :athlete_id, :score)
  end
end
