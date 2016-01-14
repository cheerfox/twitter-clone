class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :mentions, :view_at, :viewed_at
  end
end
