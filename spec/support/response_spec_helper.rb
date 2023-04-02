module ResponseSpecHelper
  # Parse JSON response to ruby hash
  def response_body
    JSON.parse(response.body)
  end
end
