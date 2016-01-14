class AddViewAtToMentions < ActiveRecord::Migration
  def change
    add_column :statuses, :view_at, :datetime
  end
end
