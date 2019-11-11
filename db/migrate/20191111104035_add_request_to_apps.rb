class AddRequestToApps < ActiveRecord::Migration
  def change
    add_column :apps, :request, :string
  end
end
