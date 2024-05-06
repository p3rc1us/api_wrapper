class Restful::V1::Client

  BASE_URL = 'https://api.restful-api.dev'.freeze

  def objects
    request(
      method: :get,
      endpoint: "objects"
    )
  end


  private

  def request(method:, endpoint:, headers: {}, body: {})
    response = connection.public_send(method, "#{endpoint}") do |request|
      request.headers = headers if headers.present?
      request.body = body.to_json if body.present?
    end

    if response.success?
      parsed_response = JSON.parse(response.body)

      if parsed_response.is_a?(Array)
        parsed_response.map { |obj| obj.with_indifferent_access }
      else
        parsed_response.with_indifferent_access
      end
   end
  end

  def connection
    @connection ||= Faraday.new(url: BASE_URL)
  end
end
