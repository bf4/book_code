json.extract! order, :id, :name, :address, :email, :pay_type, :created_at, :updated_at
json.url order_url(order, format: :json)
