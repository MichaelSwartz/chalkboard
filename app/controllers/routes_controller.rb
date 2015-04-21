class RoutesController < ApplicationController
  before_action :authenticate_user!, only:
    [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_owner_nested!, only:
    [:new, :create]
  before_action :authenticate_owner_un_nested!, only:
    [:edit, :update, :destroy]

  def index
    @round = Round.find(params[:round_id])
    redirect_to round_path(@round)
  end

  def show
    @route = Route.includes(:highpoints, :round).find(params[:id])
  end

  def new
    @round = Round.find(params[:round_id])
    @route = Route.new
  end

  def create
    @round = Round.find(params[:round_id])
    @route = @round.routes.new(route_params)

    if @route.save
      flash[:notice] = 'New route created'
      redirect_to round_path(@round)
    else
      flash[:alert] = @route.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
    @route = Route.find(params[:id])
    @round = @route.round
    @competition = @round.competition
  end

  def update
    @route = Route.find(params[:id])

    if @route.update(route_params)
      flash[:notice] = 'Route updated'
      redirect_to route_path(@route)
    else
      flash[:alert] = @route.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @route = Route.find(params[:id])
    @round = @route.round

    if @route.destroy
      flash[:alert] = "Route deleted"
      redirect_to round_path(@round)
    else
      flash[:alert] = @route.errors.full_messages.join(". ")
      render :show
    end
  end

  protected

  def authenticate_owner_nested!
    #horizon authentication methods
    @round = Round.find(params[:round_id])
    @competition = @round.competition

    unless @competition.user == current_user
      flash[:alert] = "Access restricted to competition creator"
      redirect_to round_path(@round)
    end
  end

  def authenticate_owner_un_nested!
    @route = Route.find(params[:id])
    @competition = @route.round.competition

    unless @competition.user == current_user
      flash[:alert] = "Access restricted to competition creator"
      redirect_to route_path(@route)
    end
  end

  def route_params
    params.require(:route).permit(
      :name, :max_score, :round_id)
  end
end
