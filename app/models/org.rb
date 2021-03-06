class Org < ActiveRecord::Base
  belongs_to :contact, class_name: 'User'

  has_many :apps
  has_many :comments, as: :commentable
  has_many :coaches, class_name: 'User', foreign_key: :coaching_org_id

  validates_presence_of :name, :contact_id
  validates_uniqueness_of :name

  default_scope { order :name => :asc }

  enum comment_type: []

  def address
  	[address_line_1, address_line_2, city_state_zip].compact.join(", ")
  end

  def self.for_user(contact_id)
    Org.where(:contact_id => contact_id)
  end

  def self.import(file)
    keys = ['name', 'description', 'url', 'contact_id', "address_line_1", "address_line_2", "city_state_zip", "phone"]
    CSV.foreach(file.path, headers: true) do |row|
      row = row.select { |key,_| keys.include? key }
      if row.empty?
        raise "No valid columns. Valid columns are: 'name', 'description', 'url', 'contact_id', 'address_line_1', 'address_line_2', 'city_state_zip', 'phone'"
      else
        Org.create(row.to_h)
      end
    end
  end
end
