class AddDateToPosts < ActiveRecord::Migration[5.1]
  def change
    change_table :posts do |t|
      t.integer :date
    end
  end
end
