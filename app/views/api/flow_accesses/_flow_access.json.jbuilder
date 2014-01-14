json.extract! flow_access, 'id', 'user_id', 'flow_id', 'role'

json.user do |user|
  json.partial! 'api/users/user', user: flow_access.user
end
