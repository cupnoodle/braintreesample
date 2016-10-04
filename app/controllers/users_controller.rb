class UsersController < ApplicationController
  before_action :require_login
  
  def index
    @client_token = Braintree::ClientToken.generate
  end

  def subscribe
    payment_method_nonce = params[:payment_method_nonce]

    # find if existing customer id (twitter id) exist
    begin
      customer = Braintree::Customer.find(current_user.uid)
    rescue Braintree::NotFoundError => e
      # create a customer
      customer = Braintree::Customer.create(
        :id => current_user.uid,
        :payment_method_nonce => payment_method_nonce
      )
    rescue StandardError => e
      # other exceptions
      puts e.message
      flash[:danger] = "Something wrong with payment gateway, rest assured you are not charged."
    ensure
      # always be executed
      if !customer.id.blank?
        payment_method = customer.payment_methods[0]

        result = Braintree::Subscription.create(
          :payment_method_token => payment_method.token,
          :plan_id => "premium"
        )

        if result.success?
          current_user.plan = "premium"
          current_user.subscription_id = result.subscription.id
          current_user.billing_day_of_month = result.subscription.billing_day_of_month
          current_user.save

          flash[:success] = "You have subscribed to the premium plan! Congratulation on gaining higher social status!"
        end

      else
        #p customer.errors
      end

    end

    


    redirect_to user_index_path
  end

  def unsubscribe
    #result = Braintree::Customer.delete(current_user.uid)
    result = Braintree::Subscription.cancel(current_user.subscription_id)
    if result.success?
      puts "customer successfully deleted"
      current_user.plan = "free"
      current_user.subscription_id = nil
      current_user.billing_day_of_month = nil
      current_user.save

      flash[:success] = "You have unsubscribed, welcome back peasant."
    else
      p result.errors
    end

    redirect_to user_index_path
  end

end
