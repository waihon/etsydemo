jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  payment.setupForm()

payment =
  setupForm: ->
    $('#new_order').submit ->
        $('input[type=submit]').attr('disabled', true)
        Stripe.card.createToken($('#new_order'), payment.handleStripeResponse)
        false

  handleStripeResponse: (status, response) ->
    if status == 200
      # When the credit card info is valid, add the Stripe token as a hidden field.
      #alert(response.id)
      $('#new_order').append($('<input type="hidden" name="stripeToken" />').val(response.id))
    else
      # Display the Stripe error message in the '<div id="stripe_error"...' section of _form.html.erb in orders.
      $('#stripe_error').text(response.error.message).show()
      # Re-enable the 'Complete Order ' button
      $('input[type=submit]').attr('disabled', false)
	