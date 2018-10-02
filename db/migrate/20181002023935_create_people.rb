class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.references :parent, foreign_key: {to_table: :people}

      t.timestamps
    end
  end
end
