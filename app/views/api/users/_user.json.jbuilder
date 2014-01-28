json.url api_user_url(user)
json.extract! user, 'id', 'to_s', 'username', 'full_name', 'email', 'avatar_url'
