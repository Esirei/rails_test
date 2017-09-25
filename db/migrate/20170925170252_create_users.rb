class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      # This automatically creates created_at and updated_at columns
      t.timestamps
    end
  end
end
