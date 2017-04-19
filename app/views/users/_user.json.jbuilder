json.extract! user, :id, :email, :name, :phone, :phone_short, :id_num, :office, :party_member, :authority, :created_at, :updated_at
json.url user_url(user, format: :json)