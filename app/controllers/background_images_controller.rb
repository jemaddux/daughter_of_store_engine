class BackgroundImagesController < ApplicationController
  # before_filter :require_store_admin_or_admin


  def create
    @background_image = BackgroundImage.create(params[:background_image])

    if @background_image.valid?
      @background_image.store_id = current_store.id
      @background_image.save

      #redirect to store/admin/edit path
      redirect_to :back
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

  def destroy
    @background_image = BackgroundImage.find(params[:id])
    @background_image.destroy
    redirect_to store_admin_edit_store_path(current_store)
  end

  def index
    redirect_to home_path(current_store)
  end

end
