class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :firstname
      t.string :lastname
    end
  end
end
