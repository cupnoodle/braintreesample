class AddSubscriptionDataToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subscription_id, :string
    add_column :users, :billing_day_of_month, :integer 
  end
end
