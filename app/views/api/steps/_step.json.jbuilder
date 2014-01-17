json.url api_flow_step_url(step.flow, step)
json.extract! step, 'id', 'name'

json.attachments step.attachments do |attachment|
  json.partial! 'api/attachments/attachment', attachment: attachment
end
