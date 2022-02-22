class CreatePins < ActiveRecord::Migration[7.0]
  def change
    create_table :pins do |t|
      t.string :title
      t.text :description
      t.string :latitude
      t.string :float
      t.float :longitude

      t.timestamps
    end
  end
end
