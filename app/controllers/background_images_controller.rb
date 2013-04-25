class BackgroundImagesController < ApplicationController
  # before_filter :require_store_admin_or_admin


  def new
    @background_image = BackgroundImage.new
  end

  def create
    @background_image = BackgroundImage.create(params[:background_image])

    if @background_image.valid?
      @background_image.store_id = current_store.id
      @background_image.save

      redirect_to background_image_path(current_store, @background_image)
    else
      render :new
    end
  end

  def show
    image = BackgroundImage.find(params[:id])
    if image.store_id == current_store.id
      @background_image = image
    else
      redirect_to home_path(current_store), notice:"Cannot View That Image"
    end
  end

  def edit
    @background_image = BackgroundImage.find(params[:id])
  end

  def update
    @background_image = BackgroundImage.find(params[:id])

    if @background_image.update_attributes(params[:background_image])
      @background_image.store_id = current_store.id
      @background_image.save

      redirect_to background_image_path(current_store, @background_image)
    else
      render :edit
    end
  end

  def destroy
    @background_image = BackgroundImage.find(params[:id])
    @background_image.destroy
    redirect_to store_admin_path(current_store)
  end

  def index
    redirect_to home_path(current_store)
  end
  
end
