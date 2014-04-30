# Validate the submitted bank account information
# Test that the CoffeeScript is working by using Stripe's bank account 
# numbers for testing: https://stripe.com/docs/stripe.js
jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  listing.setupForm()

listing =
  setupForm: ->
    $('#new_listing').submit ->
      # Validate bank account oly if it sees that extra form fields are present.
      if $('input').length > 6
        $('input[type=submit]').attr('disabled', true)
        Stripe.bankAccount.createToken($('#new_listing'), listing.handleStripeResponse)
        false

  handleStripeResponse: (status, response) ->
    if status == 200
      # When the credit card info is valid, add the Stripe token as a hidden field.
      #alert(response.id)
      $('#new_listing').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#new_listing')[0].submit()
    else
      # Display the Stripe error message in the '<div id="stripe_error"...' section of _form.html.erb in orders.
      $('#stripe_error').text(response.error.message).show()
      # Re-enable the 'Complete Order ' button
      $('input[type=submit]').attr('disabled', false)
	