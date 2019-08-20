json.extract! ticket, :id, :title, :content, :status, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
