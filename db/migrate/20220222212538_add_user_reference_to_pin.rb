class AddUserReferenceToPin < ActiveRecord::Migration[7.0]
  def change
    add_reference :pins, :user, index: true
  end
end
