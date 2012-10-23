class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.integer :rate
      t.text :comment

      t.timestamps
    end
  end
end
