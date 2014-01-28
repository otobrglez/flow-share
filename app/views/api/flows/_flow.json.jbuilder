json.url api_flow_url(flow)
json.public_url public_flow_url(flow)
json.public_path public_flow_path(flow)

json.extract! flow, 'id', 'token', 'name', 'created_at', 'updated_at'

json.created_ago "#{time_ago_in_words(flow.created_at)} ago"
json.updated_ago "#{time_ago_in_words(flow.updated_at)} ago"

json.public flow.public?
json.open flow.open?

json.creator do |json|
  json.partial! 'api/users/user', user: flow.creator
end

json.image do |json|
  json.partial! 'api/attachments/attachment', attachment: flow.image
end if flow.image.present?

json.steps flow.duable_steps do |step|
  json.partial! 'api/steps/step', step: step
end

json.flow_accesses flow.flow_accesses do |flow_access|
  json.partial! 'api/flow_accesses/flow_access', flow_access: flow_access
end


