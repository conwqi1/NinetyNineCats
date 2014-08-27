class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end
  
  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end
  
  def new
    @cat = Cat.new(cat_params)
  end
  
  def edit
    @cat = Cat.find(params[:id])
  end
  
  def show
    @cat = Cat.find(params[:id])
  end
  
  def destroy
    @cat =  Cat.find(params[:id])
    @cat.destroy!
    redirect_to :index
  end
  
  def update
    @cat =Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end
   
  private
  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :name, :sex, :description)
  end
end
