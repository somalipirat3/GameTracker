class HomeController < ApplicationController
  
  def index
    api = ConsumeApi::Ala.new({username: 'somalipirate420_', platform: 'PS4'})
    render json: api.legend
  end

end
