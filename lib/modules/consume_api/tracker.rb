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
            players: create_user(response['data']),
            endpoint: response
        }
    end

    private

    def create_user(segments)
        player =  Player.find_or_create_by(username: @data[:username])
        game = Game.find_by(title: "Apex Legends")
        game.members.find_or_create_by(player_id: player.id, identifier: "#{player.id.to_s}|#{game.id.to_s}")
        create_legends(game.id,player.id,segments)
        return { 
            player: player.username, 
            game: game, 
            game_members: game.members.map { |member| { player: member.player} }
        }
    end

    def create_legends(game,player,segments)
        segments['segments'].each do |segment|
            if segment['type'] == "legend"
                legend = Legend.find_or_create_by(player_id: player, game_id: game, name: segment['metadata']['name']) 
                # set and update segments
                stats = Stat.find_or_create_by(player_id: player, legend_id: legend.id, identifier: "#{legend.name}|#{player.to_s}|#{legend.id.to_s}")
                stats.update(
                    rank: segment['rank'] ,
                    percentile: segment['percentile'] ,
                    displayName: segment['displayName'],
                    displayCategory: segment['displayCategory'], 
                    category: segment['category'], 
                    metadata: segment['metadata'], 
                    value: segment['value'], 
                    displayValue: segment['displayValue'],
                    displayType:  segment['displayType']
                )
            end
        end
    end

end