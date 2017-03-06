class InitialMigration < ActiveRecord::Migration

  def change

    create_table :users, :force => true do |t|
      t.string :name
      t.string :email
      t.string :github_uid
      t.timestamps
    end

    create_table :orgs, :force => true do |t|
      t.string :name
      t.string :description
      t.string :url
      t.references :contact, :index => true, :foreign_key => {:to_table => 'users'} 
      t.timestamps
    end

    create_table :apps, :force => true do |t|
      t.references :org, :index => true, :foreign_key => true

      t.integer :status, :default => 0 # see app.rb for enum types

      t.string :name
      t.string :description
      t.string :deployment_url
      t.string :repository_url
      t.timestamps
    end

    create_table :engagements, :force => true do |t|
      t.references :app, :index => true, :foreign_key => true
      t.string :team_number
      t.datetime :start_date

      # Contact person within the client org
      t.references :contact, :index => true, :foreign_key => {:to_table => 'users'}

      # Coach and org the coach belongs to
      t.references :coach, :index => true, :foreign_key => {:to_table => 'users'}
      t.references :coaching_org, :index => true, :foreign_key => {:to_table => 'orgs'}
      t.string :screencast_url
      t.string :screenshot_url  # eg for poster preview
      t.string :poster_url
      t.string :presentation_url # final report or project presentation
      t.string :prototype_deployment_url

      t.string :student_names

      t.timestamps
    end

    
  end
end
