json.array!(@todos) do |todo|
  json.extract! todo, :id, :title, :complete
  json.url todo_url(todo, format: :json)
end
