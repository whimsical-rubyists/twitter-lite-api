class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: false do |t|
      t.string :id, limit: 36, primary_key: true, null: false
      t.string :username
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
