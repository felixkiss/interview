class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :amount
      t.datetime :issue_date, index: true
    end
  end
end
