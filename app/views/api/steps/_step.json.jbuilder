json.url api_flow_step_url(step.flow, step)
json.extract! step, 'id', 'name'

json.image do |json|
  json.partial! 'api/attachments/attachment', attachment: step.image
end if step.image.present?

json.attachments step.attachments do |attachment|
  json.partial! 'api/attachments/attachment', attachment: attachment
end
