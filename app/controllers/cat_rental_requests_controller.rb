class CatRentalRequestsController < ApplicationController
  
  def index
    @rentals = CatRentalRequest.all
  end
  
  def show
    @rental = CatRentalRequest.find(params[:id])
  end
  
  def new
    @cats = Cat.all
    @rental = CatRentalRequest.new(rental_params)
  end
  
  def create
    @rental = CatRentalRequest.new(rental_params)
    if @rental.save
      redirect_to cat_rental_request_url(@rental)
    else
      render :new
    end
    
  end
  

    
  private
  
  def rental_params
    params.require(:cat_rental_request)
    .permit(:cat_id, :start_date, :end_date, :status)
  end
end


