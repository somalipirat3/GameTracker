class Api::V1::ApexlegendsController < ApplicationController

    def index
        api = ConsumeApi.apex_legends({request_type: 'profile', platform: params[:platform], username: params[:username]})
        render json: api[:search_result]
    end

    def search 
        legends = Legend.all

        render json: Player.all.map{|player| 
            {
                playerDisplayeName: player.username,
                playerDisplayeid: player.id,
                playerPlatform: player.platform,
                members: player.members.map { |member| { identifier: member.identifier, game: member.game }},
                stats: legends.map { |legend| {legendDisplayName: legend.name, stats: legend.stats} }
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