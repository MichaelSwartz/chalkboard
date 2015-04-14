class AthletesController < ApplicationController
  before_action :authenticate_user!, only:
    [:new, :create, :edit, :update, :destroy]

  def index
    @athletes = Athlete.order(:last_name)
  end

  def show
    @athlete = Athlete.find(params[:id])
  end

  def new
    @athlete = Athlete.new
  end

  def create
    @athlete = Athlete.new(athlete_params)

    if @athlete.save
      flash[:notice] = 'New athlete added'
      redirect_to athletes_path
    else
      flash[:alert] = @athlete.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
    @athlete = Athlete.find(params[:id])
  end

  def update
    @athlete = Athlete.find(params[:id])

    if @athlete.update(athlete_params)
      flash[:notice] = 'Athlete updated'
      redirect_to athletes_path
    else
      flash[:alert] = @athlete.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @athlete = Athlete.find(params[:id])

    if @athlete.destroy
      flash[:notice] = "Athlete deleted"
      redirect_to athletes_path
    else
      flash[:notice] = @athlete.errors.full_messages.join(". ")
      render :show
    end
  end

  protected

  def athlete_params
    params.require(:athlete).permit(
      :first_name, :last_name, :gender, :date_of_birth, :team)
  end
end
