class RoutesController < ApplicationController
  before_action :authenticate_user!, only:
    [:new, :create, :edit, :update, :destroy]

  def index
    @round = Round.find(params[:round_id])
    redirect_to round_path(@round)
  end

  def show
    @route = Route.find(params[:id])
    @round = @route.round
    @competition = @round.competition
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
  end

  def update
    @route = Route.find(params[:id])

    if @route.update(route_params)
      flash[:notice] = 'route updated'
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
      flash[:alert] = "route deleted"
      redirect_to round_path(@round)
    else
      flash[:alert] = @route.errors.full_messages.join(". ")
      render :show
    end
  end

  protected

  def route_params
    params.require(:route).permit(
      :name, :scored_holds, :round_id)
  end
end
