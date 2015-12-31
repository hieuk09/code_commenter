class AddHookIdToRepository < ActiveRecord::Migration
  def change
    add_column :repositories, :hook_id, :integer
  end
end
