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
      t.references :org, :index => true, :foreign_key => true

      t.integer :status, :default => 0 # see app.rb for enum types

      t.string :name
      t.string :description
      t.string :deployment_url
      t.string :repository_url
    end

    create_table :engagements, :force => true do |t|
      t.references :app, :index => true, :foreign_key => true
      t.string :team_number
      t.datetime :start_date

      t.string :contact_name    # may be different from main org contact
      t.string :contact_email

      t.string :screencast_url
      t.string :screenshot_url  # eg for poster preview
      t.string :poster_url
      t.string :presentation_url # final report or project presentation
      t.string :prototype_deployment_url

      t.string :student_names
    end

    
  end
end
