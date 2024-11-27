require 'json'
require 'csv'

class Restful::V1::Client
  BASE_URL = 'https://bored-api.appbrewery.com/'.freeze

  def objects(times, format)
    result = []
    times.times do
      response = request(
      method: :get,
      endpoint: 'random'
    )
      result << response if response
    end

    case format
    when :json
      save_as_json(result)
    when :csv
      save_as_csv(result)
    when :console
      print_to_console(result)
    else
      puts "Please make sure it's the right format"
    end
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

  def save_as_json(data)
    File.open("data.json", "w") do |f|
      f.write(JSON.pretty_generate(data))
    end
    puts "Data saved to data.json"
  end

  def save_as_csv(data)
    data.compact!

    return if data.empty?

    CSV.open("data.csv", "w") do |csv|
      csv << data.first.keys
      data.each do |result|
        csv << result.values
      end
    end

    puts 'Data saved to data.csv'
  end

  def print_to_console(data)
    data.each do |result|
      puts result
    end
  end
end
