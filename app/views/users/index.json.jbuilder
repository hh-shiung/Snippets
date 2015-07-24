json.array!(@users) do |user|
  json.extract! user, :id, :user_id, :email, :password, :is_email_confirm, :is_active, :user_type, :token, :avatar
  json.url user_url(user, format: :json)
end
