# Tracker.gg api
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
        player =  Player.where(username: @data[:username]).first || Player.create!(username: @data[:username])
        game = Game.where(title: "Apex Legends").first
        game.members.build(player_id: player.id, identifier: "#{player.id.to_s}|#{game.id.to_s}")
        return { player: player.username, game: game, game_members: game.members }
    end

        # def set_player
        #     begin
        #         player = Player.create!(username: @data[:username])
        #         add_player_to_game_list(player.id)
        #     rescue Mongo::Error::OperationFailure => e
        #         player = Player.where(username: @data[:username]).first
        #     end
        # end

        # def add_player_to_game_list(player_id)
        #     begin
        #         game = Game.where(title: "Apex Legends").first
        #         Member.create!(game_id: game.id, player_id: player_id)
        #     rescue Mongo::Error::OperationFailure => e
        #         player = Player.where(username: @data[:username]).first
        #     end
        # end

end