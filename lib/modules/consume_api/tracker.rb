# Tracker.gg api
# Full profile requests 
class ConsumeApi::Tracker
    include HTTParty

    def initialize(options = {})
        @data = options
        @api_key = Rails.application.credentials.api_keys[:tracker_gg][:key]
        @endpoint = Rails.application.credentials.api_keys[:tracker_gg][:endpoint]  
    end

    def profile
        @endpoint = "#{@endpoint}apex/standard/profile/#{@data[:platform]}/#{@data[:username]}"
        response = self.class.get(@endpoint, headers: {"TRN-Api-Key": @api_key})

        return {
            players: create_user,
            endpoint: response
        }
    end

    private

    def create_user
        player =  Player.find_or_create_by(username: @data[:username])
        game = Game.find_by(title: "Apex Legends")
        game.members.find_or_create_by(player_id: player.id, identifier: "#{player.id.to_s}|#{game.id.to_s}")
        return { 
            player: player.username, 
            game: game, 
            game_members: game.members.map { |member| { player: member.player} }
        }
    end

end