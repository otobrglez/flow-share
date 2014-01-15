json.extract! flow, 'id', 'name', 'created_at', 'updated_at'

json.created_ago "#{time_ago_in_words(flow.created_at)} ago"
json.updated_ago "#{time_ago_in_words(flow.updated_at)} ago"

json.creator do |json|
  json.partial! 'api/users/user', user: flow.creator
end

json.steps flow.steps.rank(:row_order) do |step|
  json.partial! 'api/steps/step', step: step
end

json.flow_accesses flow.flow_accesses do |flow_access|
  json.partial! 'api/flow_accesses/flow_access', flow_access: flow_access
end

