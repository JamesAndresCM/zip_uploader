json.extract! file_resource, :id, :name, :created_at, :updated_at
json.url file_resource_url(file_resource, format: :json)
