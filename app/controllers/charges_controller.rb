class ChargesController < ApplicationController

  def create

    @user = current_user
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
    customer: customer.id, # Note -- this is NOT the user_id in your app
    amount: Amount.default,
    description: "BigMoney Membership - #{current_user.email}",
    currency: 'usd'
    )

    @user.update_attributes(role: "premium")

    flash[:notice] = "Thanks for all the money, #{current_user.email}! You can now have a more enjoyable experience"
    redirect_to root_path # or wherever

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end


  def new
    # binding.pry
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: Amount.default
    }
  end

  private

  def upgrade_user_role
    @user.role = 'premium'
  end


end
