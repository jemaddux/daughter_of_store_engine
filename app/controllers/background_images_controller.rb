class BackgroundImagesController < ApplicationController

  def create
    @background_image = BackgroundImage.create(params[:background_image])

    if @background_image.valid?
      @background_image.store_id = current_store.id
      @background_image.save
      redirect_to :back
    else
      render :new
    end
  end

  def show
    redirect_to home_path(current_store)
  end

  def destroy
    @background_image = BackgroundImage.find(params[:id])
    @background_image.destroy
    redirect_to store_admin_edit_store_path(current_store),
      notice:"Image has been marked for deletion. Give us a few moments."
  end

  def index
    redirect_to home_path(current_store)
  end

end
