class Restful::V1::Client

  BASE_URL = 'https://api.restful-api.dev/'.freeze

  def objects
    request(
      method: :get,
      endpoint: "objects"
    )
  end

  def specific_object(id)
    request(
      method: :get,
      endpoint: "objects/#{id}"
    )
  end

  private

  def request(method:, endpoint:, headers: {}, body: {})
  response = connection.public_send(method, "#{endpoint}") do |request|
     request.headers = headers if headers.present?
     request.body = body.to_json if body.present?
  end

  if response.success?
     begin
       JSON.parse(response.body).with_indifferent_access
     rescue JSON::ParserError => e
       Rails.logger.error "Failed to parse JSON: #{e.message}"
       nil
     end
  else
     nil
  end
 end

  def connection
    @connection ||= Faraday.new(url: BASE_URL)
  end
end
