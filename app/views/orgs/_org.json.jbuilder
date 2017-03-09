json.extract! org, :id, :name, :description, :url, :contact_name, :contact_email, :primary_phone, :secondary_phone, :created_at, :updated_at
json.url org_url(org, format: :json)
