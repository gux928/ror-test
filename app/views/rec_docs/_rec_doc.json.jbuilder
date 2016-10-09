json.extract! rec_doc, :id, :wjnr, :riqi, :created_at, :updated_at
json.url rec_doc_url(rec_doc, format: :json)