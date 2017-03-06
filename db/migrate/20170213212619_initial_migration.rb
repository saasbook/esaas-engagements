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
      t.belongs_to :contact, :index => true, :references => 'courses'
      t.timestamps
    end

    create_table :apps, :force => true do |t|
      t.belongs_to :org, :index => true, :foreign_key => true

      t.integer :status, :default => 0 # see app.rb for enum types

      t.string :name
      t.string :description
      t.string :deployment_url
      t.string :repository_url
      t.timestamps
    end

    create_table :engagements, :force => true do |t|
      t.belongs_to :app, :index => true, :foreign_key => true
      t.string :team_number
      t.datetime :start_date

      # Contact person within the client org
      t.belongs_to :contact, :index => true, :references => 'users'

      # Coach and org the coach belongs to
      t.belongs_to :coach, :index => true,  :references => 'users'
      t.belongs_to :coaching_org, :index => true, :references => 'orgs'
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
