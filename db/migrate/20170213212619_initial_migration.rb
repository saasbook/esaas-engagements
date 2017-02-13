class InitialMigration < ActiveRecord::Migration

  def change

    create_table :organizations, :force => true do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :contact_name
      t.string :contact_email
      t.string :primary_phone
      t.string :secondary_phone
    end

    create_table :apps, :force => true do |t|
      t.string :description
      t.string :deployment_url
      t.string :repository_url
      t.string
    end

    create_table :engagements, :force => true do |t|
      t.belongs_to :organization
      t.belongs_to :app
      t.string :category        # :development, :maintenance, :inactive
      t.datetime :start_date

      t.string :screencast_url
      t.string :poster_preview_url
      t.string :poster_url
      t.string :presentation_url
      t.string :prototype_deployment_url

      t.string :student_names
    end

    
  end
end
