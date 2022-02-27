require 'stripe'

Rails.configuration.stripe = {
    secret_key: ENV['STRIPE_SECRET_KEY'],
    publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

# price_id = '{{PRICE_ID}}'

# session = Stripe::Checkout::Session.create({
#     success_url: 'https://example.com/success.html?session_id={CHECKOUT_SESSION_ID}',
#     cancel_url: 'https://example.com/canceled.html',
#     mode: 'subscription',
#     line_items: [{
#         # For metered billing, do not pass quantity
#         quantity: 1,
#         price: price_id,
#     }],
# })
