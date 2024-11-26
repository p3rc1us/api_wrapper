class PagesController < ApplicationController
  def index
    client = Restful::V1::Client.new
    @objects = client.objects
  end

  def select
    client = Restful::V1::Client.new
    @object_id = params[:object_id]
    @object = client.specific_object(@object_id)
  end

  def add
    client = Restful::V1::Client.new
    @details = {
      "name": params[:name],
      "data": {
        "year": params[:year],
        "price": params[:price]
      }
    }
    @object = client.add_object(@details)

    redirect_to root_path
  end
end
