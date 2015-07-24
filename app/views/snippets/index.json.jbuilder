json.array!(@snippets) do |snippet|
  json.extract! snippet, :id, :snippet_title, :snippet_description, :snippet_content, :snippet_view_count
  json.url snippet_url(snippet, format: :json)
end
