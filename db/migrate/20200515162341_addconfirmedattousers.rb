class Addconfirmedattousers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :confirmed_at, :datetime, :default => Time.now.utc
  end
end
