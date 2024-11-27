class PagesController < ApplicationController
  def index
    client = Restful::V1::Client.new
    @objects = client.objects(1)
  end

  def download_json
    client = Restful::V1::Client.new
    @objects = client.objects(1)
    send_data JSON.pretty_generate(@objects), filename: "data.json", type: "application/json"
  end

  def download_csv
    client = Restful::V1::Client.new
    @objects = client.objects(1).compact

    return if @objects.empty?

    csv_data = CSV.generate(headers: true) do |csv|
      csv << @objects.first.keys
      @objects.each do |object|
        csv << object.values
      end
    end
    send_data csv_data, filename: "data.csv", type: "text/csv"
  end

  def print_console
    client = Restful::V1::Client.new
    @objects = client.objects(1)
    @objects.each { |object| puts object }
    redirect_to root_path, notice: "Data printed to console"
  end
end
