class RenamePasswordToPasswordDigestInMembers < ActiveRecord::Migration[5.1]
  def change
    rename_column :members, :password, :password_digest
  end
end
