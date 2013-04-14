class Address < ActiveRecord::Base
  attr_accessible :city,
                  :phone, 
                  :state, 
                  :status, 
                  :street, 
                  :zipcode,
                  :customer_id

  belongs_to :customer

  def key
    {1=>"Billing", 2=>"Shipping", 3=> "Billing and Shipping", 4=> "inactive"}
  end

  def type
    key[status]  
  end

end
