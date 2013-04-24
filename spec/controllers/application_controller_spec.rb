require 'spec_helper'

describe ApplicationController do
  it "should" do
    current_store = Store.first
    get :require_store_admin_or_admin, current_store
  end
end
