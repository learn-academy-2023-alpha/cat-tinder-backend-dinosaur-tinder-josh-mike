class CreateDinosaurs < ActiveRecord::Migration[7.0]
  def change
    create_table :dinosaurs do |t|
      t.string :name
      t.bigint :age
      t.string :diet
      t.text :enjoys
      t.text :image

      t.timestamps
    end
  end
end
