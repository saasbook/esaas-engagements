json.extract! app, :id, :description, :deployment_url, :repository_url, :created_at, :updated_at
json.url app_url(app, format: :json)