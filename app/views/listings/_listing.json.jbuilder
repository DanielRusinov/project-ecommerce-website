json.extract! listing, :id, :title, :description, :price, :created_at, :updated_at
json.url listing_url(listing, format: :json)
