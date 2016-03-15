json.array!(@attachments) do |attachment|
  json.extract! attachment, :id, :file, :user_id, :num_queue
  json.url attachment_url(attachment, format: :json)
end
