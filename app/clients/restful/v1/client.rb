class Restful::V1::Client
  BASE_URL = 'https://bored-api.appbrewery.com/'.freeze

  def objects(times)
    result = []
    times.times do
      response = request(
      method: :get,
      endpoint: 'random'
    )
    result << response if response
    end
    result
  end

  private

  def request(method:, endpoint:, headers: {}, body: {})
    headers['Content-Type'] = 'application/json'

    response = connection.public_send(method, "#{endpoint}") do |request|
      request.headers = headers if headers.present?
      request.body = body.to_json if body.present?
    end

    return unless response.success?

    begin
      parsed_response = JSON.parse(response.body)
        if parsed_response.is_a?(Array)
          parsed_response.map { |obj| obj.with_indifferent_access }
        elsif parsed_response.is_a?(Hash)
          parsed_response.with_indifferent_access
        end
    rescue JSON::ParserError => e
      Rails.logger.error "Failed to parse JSON: #{e.message}"
      Rails.logger.error "Response body: #{response.body}"
      nil
    end
  end

  def connection
    @connection ||= Faraday.new(url: BASE_URL)
  end
end
