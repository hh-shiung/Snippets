json.array!(@userfeedbacks) do |userfeedback|
  json.extract! userfeedback, :id, :email, :feedback
  json.url userfeedback_url(userfeedback, format: :json)
end
