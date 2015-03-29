class AddMoreColumnsToUsers < ActiveRecord::Migration
  def change
		add_column :users, :username, :string,            :null => false, :unique => true, :default => ""
		add_column :users, :last_name, :string,           :default => ""
    add_column :users, :first_name, :string
    add_column :users, :photo, :string		
		add_column :users, :birthdate, :date            
		add_column :users, :origin_country, :string       
		add_column :users, :current_city, :string      						        	
		add_column :users, :current_country, :string            
		add_column :users, :description, :string            
		add_column :users, :activity, :string
		add_column :users, :thrusted, :integer

    add_column :users, :provider, :string
    add_column :users, :uid, :string

		change_column	:users, :email, :string, :unique => true
  end
end