class HomeController < ApplicationController
  
  def index
    # ConsumeApi::Ala.new({username: 'somalipirate420_', platform: 'PS4'})
    @game = Game.where(title: "Apex Legends").first
    render json: {
      game: @game,
      members: @game.members
    }
  end

end
