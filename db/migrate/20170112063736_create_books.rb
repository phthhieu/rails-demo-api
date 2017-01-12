class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.references :library, foreign_key: true
      t.string :title
      t.timestamps
    end
  end
end
