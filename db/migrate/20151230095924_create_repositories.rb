class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name
      t.string :path
      t.string :link
      t.timestamps null: false
    end
  end
end
