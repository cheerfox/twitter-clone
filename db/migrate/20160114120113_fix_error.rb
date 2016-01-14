class FixError < ActiveRecord::Migration
  def change
    remove_column :statuses, :view_at
    add_column :mentions, :view_at, :datetime
  end
end
