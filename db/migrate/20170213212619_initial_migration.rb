class InitialMigration < ActiveRecord::Migration

  def change

    create_table :orgs, :force => true do |t|
      t.string :name
      t.string :description
      t.string :url
      t.string :contact_name
      t.string :contact_email
    end

    create_table :apps, :force => true do |t|
      t.string :description
      t.string :deployment_url
      t.string :repository_url
      t.string
    end

    create_table :engagements, :force => true do |t|
      t.references :org, :index => true, :foreign_key => true
      t.references :app, :index => true, :foreign_key => true
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
