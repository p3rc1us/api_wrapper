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

  def add_object(details)
    data = details["data"]
    if data.present?
      request(
        method: :post,
        endpoint: "objects",
        body: {
          "name" => details[name],
          "data" => {
            "year" => data[year],
            "price" => data[price],
            "model" => data[model]
          }
        }
      )
    else
      Rails.logger.error "Data is missing or nil in details: #{details.inspect}"
      nil
    end
  end

  private

  def request(method:, endpoint:, headers: {}, body: {})
  headers['Content-Type'] = 'application/json'

  response = connection.public_send(method, "#{endpoint}") do |request|
     request.headers = headers if headers.present?
     request.body = body.to_json if body.present?
  end

  if response.success?
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
  else
     nil
  end


  end

  def connection
    @connection ||= Faraday.new(url: BASE_URL)
  end
end
