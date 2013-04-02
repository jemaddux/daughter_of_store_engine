module Sorcery
  module TestHelpers
    module Rails
      def login_customer_post(customer, password)
        page.driver.post(customer_sessions_path, { username: customer, password: password}) 
      end
    end
  end
end