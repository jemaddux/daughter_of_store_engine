class Customer < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_confirmation_of :password, message: "Password should match confirmation.", if: :password
  # attr_accessible :title, :body
end
