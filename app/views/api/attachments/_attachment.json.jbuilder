json.extract! attachment, :id

json.name attachment.name
json.short_name truncate(attachment.name, length: 20)
json.content_type attachment.content_type

json.file_url attachment.url
json.thumb_url attachment.try(:thumb).try(:url)
json.file_size attachment.file_size

json.human_file_size number_to_human_size(attachment.file_size)
