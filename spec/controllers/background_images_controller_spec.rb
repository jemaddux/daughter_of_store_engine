require 'spec_helper'

describe BackgroundImagesController do
  
  context "GET #new" do 
    it "should be valid" do
      pending 
      controller.stub(:scope_current_store)
      controller.stub(:shopping_cart)
      # controller.stub(:current_store).and_return( mock(id: 1) )
      get :new
      expect(assigns(:background_image))
    end
  end

end
