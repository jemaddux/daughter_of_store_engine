if Rails.env == 'development'
  Rails.configuration.stripe = {
      :publishable_key => 'pk_test_dcZPdQdqpoZeFT6OjmTa81y5',
  :secret_key      => 'sk_test_cXDCJbIMRckoiuLuIFQQoRDi'
  }
else
  Rails.configuration.stripe = {
      :publishable_key => ENV['PUBLISHABLE_KEY'],
      :secret_key      => ENV['SECRET_KEY']
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]