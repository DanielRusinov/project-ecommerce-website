class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @listings = Listing.all
  end

  def show
  end

  def new
    @listing = current_user.listings.build
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def edit
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def create
    @listing = current_user.listings.build(listing_params)
    @listing.category_id = params[:category_id] 

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        @categories = Category.all.map{|c| [ c.name, c.id ] }
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def update  
  @listing.category_id = params[:category_id]
   
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        @categories = Category.all.map{|c| [ c.name, c.id ] }
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:title, :description, :price, :image)
    end
end
