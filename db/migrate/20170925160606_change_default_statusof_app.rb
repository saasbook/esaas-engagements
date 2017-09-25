class ChangeDefaultStatusofApp < ActiveRecord::Migration
  def change
  	change_column_default :apps, :status, 5
  end
end
