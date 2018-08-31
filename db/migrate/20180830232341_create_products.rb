class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :code
      t.string :descripcion
      t.integer :quantity
      t.integer :valor
      t.references :file_resource, foreign_key: true

      t.timestamps
    end
    add_index :products, :code
  end
end
