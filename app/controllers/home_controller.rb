class HomeController < ApplicationController
  
  def index
    # ConsumeApi::Ala.new({username: 'somalipirate420_', platform: 'PS4'})
    @games = Game.all.map { |game| {title: game.title, members: game.members.map { |member| {id: member.id, player: member.player_id.to_s, game: member.game_id, identifier: member.identifier }}} }
    render json: @games
  end

end
