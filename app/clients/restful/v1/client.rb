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
      JSON.parse(response.body).map { |obj| obj.with_indifferent_access }
   end
  end

  def connection
    @connection ||= Faraday.new(url: BASE_URL)
  end
end
