class BibsController < ApplicationController
  before_action :authenticate_user!, only:
    [:index, :create, :edit, :update, :destroy]
  before_action :authenticate_owner_nested!, only:
    [:index, :create]
  before_action :authenticate_owner_un_nested!, only:
    [:edit, :update, :destroy]

  def index
    @competition = Competition.find(params[:competition_id])
    @athletes = Athlete.order(:last_name)
    @bibs = @competition.bibs.where.not(athlete: nil)
    @bib = @competition.bibs.new
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @bib = @competition.bibs.new(bib_params)

    if @bib.save
      flash[:notice] = 'Athlete registered for competition'
      redirect_to competition_bibs_path(@competition)
    else
      flash[:alert] = @bib.errors.full_messages.join(". ")
      redirect_to competition_bibs_path(@competition)
    end
  end

  def edit
    @bib = Bib.find(params[:id])
    @competition = @bib.competition
  end

  def update
    @bib = Bib.find(params[:id])

    if @bib.update(bib_params)
      flash[:notice] = 'Bib updated'
      redirect_to competition_bibs_path(@competition)
    else
      flash[:alert] = @bib.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @bib = Bib.find(params[:id])
    @competition = @bib.competition

    if @bib.destroy
      flash[:alert] = "Athlete removed from competition"
      redirect_to competition_bibs_path(@competition)
    else
      flash[:alert] = @bib.errors.full_messages.join(". ")
      redirect_to competition_bibs_path(@competition)
    end
  end

  protected

  def authenticate_owner_nested!
    @competition = Competition.find(params[:competition_id])

    unless @competition.user == current_user
      flash[:alert] = "Access restricted to competition creator"
      redirect_to competition_path(@competition)
    end
  end

  def authenticate_owner_un_nested!
    @bib = bib.find(params[:id])
    @competition = @bib.competition

    unless @competition.user == current_user
      flash[:alert] = "Access restricted to competition creator"
      redirect_to competition_path(@competition)
    end
  end

  def bib_params
    params.require(:bib).permit(
      :number, :athlete_id, :competition_id)
  end
end
