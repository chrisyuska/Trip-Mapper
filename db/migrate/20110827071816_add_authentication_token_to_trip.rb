class AddAuthenticationTokenToTrip < ActiveRecord::Migration
  def self.up
    add_column :trips, :authentication_token, :string
  end

  def self.down
    remove_column :trips, :authentication_token
  end
end
