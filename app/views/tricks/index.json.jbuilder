json.array!(@tricks) do |trick|
  json.extract! trick, :id, :name, :core, :active
  json.url trick_url(trick, format: :json)
end
