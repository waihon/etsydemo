class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  # Check that the user is signed in
  before_action :authenticate_user!

  # Add 2 new actions to the Orders controller that correspond to the 2 new URLs defined in routes.rb
  def sales
    @orders = Order.all.where(seller: current_user).order("created_at DESC")
  end

  def purchases
    @orders = Order.all.where(buyer: current_user).order("created_at DESC")
  end
 
  # Prevent Users from modifying their existing Orders by deleting the index, show, edit,
  # update, and destroy actions.
  # We'll also delete the corresponding view pages:
  # edit.html.erb, index.html.erb, index.json.jbuilder, show.html.erb, show.json.jbuilder

  # GET /orders/new
  def new
    @order = Order.new
    @listing = Listing.find(params[:listing_id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @listing = Listing.find(params[:listing_id])

    # Make sure the buyer_id column is set when an Order is created
    @order.buyer_id = current_user.id
    # Make sure the listing_id and seller_id columns are set when an Order is created
    @order.listing_id = @listing.id
    @seller = @listing.user
    @order.seller_id = @seller.id

    # Charge the credit card.
    # The stripeToken was set in orders.js.coffee script
    Stripe.api_key = ENV["STRIPE_API_KEY"]
    token = params[:stripeToken]

    begin
      # Convert dollars to cents and round down to integer
      charge = Stripe::Charge.create(
        :amount => (@listing.price * 100).floor,
        :currency => "usd", 
        :card => token
        )
      # Don't display the thank-you message yet as there might be other non-card-related errors
      #flash[:notice] = "Thanks for ordering!"
    rescue Stripe::CardError => e
      flash[:danger] = e.message
    end

    # Transfer funds to the seller's bank account when an Order is placed.
    # Charge 5% fee and transfer 95% to the seller. Price is in cents.
    transfer = Stripe::Transfer.create(
      :amount => (@listing.price * 95).floor,
      :currency => "usd",
      :recipient => @seller.recipient
      )

    respond_to do |format|
      if @order.save
        # Redirect to root url instead of order page 
        format.html { redirect_to root_url, notice: 'Thanks for ordering!' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:address, :city, :state)
    end
end
