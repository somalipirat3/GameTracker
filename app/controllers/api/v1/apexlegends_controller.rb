class Api::V1::ApexlegendsController < ApplicationController

    def index
        api = ConsumeApi.apex_legends({request_type: 'profile', platform: params[:platform], username: params[:username]})
        render json: api[:search_result]
    end

    def scrapper_test
        results = ConsumeApi.apexlegends_data({request_type: 'profile', platform: params[:platform], username: params[:username]})
        render json: results
    end

    def search 
        legends = Legend.all
        players = Player.where('$text' => {'$search' => params[:username]}).to_a

        render json: players.map{|player| 
            {
                playerDisplayeName: player.username,
                legends: legends,
                playerDisplayeid: player.id,
                playerPlatform: player.platform,
                members: player.members.map { |member| { identifier: member.identifier, game: member.game }},
                stats: player.stats.map { |stat| stat.data }
            }
        }
    end

end

# legend 
#     belongs_to member
#     belongs_to game

#     name: uniq
#     imageUrl: [link_to_image]
#     bgImageUrl: [link_to_image]
#     tallImageUrl: [link_to_image]


# member 
#     has_many legends