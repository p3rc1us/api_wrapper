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

end
