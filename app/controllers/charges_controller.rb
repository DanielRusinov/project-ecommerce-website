class ChargesController < ApplicationController
  rescue_from Stripe::CardError, with: :catch_exception
  def new
  end

  def create
    @listing = Listing.find_by_id(params[:id])
    StripeChargesServices.new(charges_params, current_user, @listing).call
    @listing.update(order_first: true)
    redirect_to listings_path, :alert => 'Thank you for your purchase!!'
  end

  private

  def charges_params
    params.permit(:stripeToken)
  end

  def catch_exception(exception)
    flash[:error] = exception.message
  end

  class StripeChargesServices
    DEFAULT_CURRENCY = 'usd'.freeze
    DEFAULT_AMOUNT = 500
    
    def initialize(params, user, listing)
      @stripe_token = params[:stripeToken]
      @listing = listing.id
      @user = user
    end

    def call
      create_charge(find_customer)
    end

    private

    attr_accessor :user, :stripe_token, :listing

    def find_customer
      if user.stripe_token
        retrieve_customer(user.stripe_token)
      else
        create_customer
      end
    end

    def retrieve_customer(stripe_token)
        Stripe::Customer.retrieve(stripe_token)

    end

    def create_customer
      customer = Stripe::Customer.create(
        source: stripe_token
      )
      user.update(stripe_token: customer.id)
      customer
    end

    def create_charge(customer)
      Stripe::Charge.create(
        customer: customer.id,
        amount: DEFAULT_AMOUNT,
        description: listing,
        currency: DEFAULT_CURRENCY
      )

      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path
        
    end
  end
end