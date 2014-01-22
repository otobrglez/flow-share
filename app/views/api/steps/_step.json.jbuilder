json.url api_flow_step_url(step.flow, step)
json.extract! step, 'id', 'name'

json.completed step.completed?

json.image do |json|
  json.partial! 'api/attachments/attachment', attachment: step.image
end if step.image.present?

json.attachments step.attachments do |attachment|
  json.partial! 'api/attachments/attachment', attachment: attachment
end

json.assignee do |json|
  json.partial! 'api/users/user', user: step.assignee
end if step.assignee_id?

json.achiever do |json|
  json.partial! 'api/users/user', user: step.achiever
end if step.achiever_id?
