class Api::V1::ApexlegendsController < ApplicationController

    def index
        api = ConsumeApi.apex_legends({request_type: 'profile', platform: params[:platform], username: params[:username]})
        render json: api[:search_result]
    end

    def search 
        render json: Player.all.map{|player| 
            {
                playerDisplayeName: player.username,
                playerPlatform: player.platform,
                members: player.members.map { |member| {identifier: member.identifier, game: member.game}}
            } 
        }
    end

end

# legend 
#     belongs_to member
#     belongs_to game
#     name: uniq
#     imageUrl: [link_to_image],
#     bgImageUrl: [link_to_image],
#     tallImageUrl: [link_to_image],


# member 
#     has_many legends
