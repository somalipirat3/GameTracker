class Api::V1::ProfilesController < ApplicationController
    
    def show
        if(params.has_key?(:username) && params.has_key?(:platform))
            username = params[:username]
            platform = params[:platform]

            @player = Player.find_or_create_by(username: username, platform: platform)
            @game = Game.find_by(title: 'Apex Legends')

            @set_legends = Legend.all.map {|legend|
                {name: legend.name , stats: Stat.where(legend_id: legend.id, player_id: @player.id)}
            }
            # run the data scrapper
            ConsumeApi.apexlegends_data({request_type: 'profile', platform: platform, username: username })
        else
            render json: {
                params: params,
                time_stamp: Time.now
            }
        end
    end

    def search
        username = params[:username]
        @players = Player.where('$text' => {'$search' => username})
    end

    private

    def filter_by_legends()
        Legend.all.map {|legend|
            {name: legend.name , stats: Stat.where(legend_id: legend.id, player_id: player.id)}
        }
    end

end