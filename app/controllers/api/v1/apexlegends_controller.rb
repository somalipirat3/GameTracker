class Api::V1::ApexlegendsController < ApplicationController

    def search
        # excepted params platform "PC", "PS4" or "X1"
        if (["PC", "PS4" , "X1"].include? params[:platform])
            api = ConsumeApi::Ala.new({username: params[:username], platform: params[:platform]})
            render json: api.legend
        else
            render_error_msg({
                invalid_platform: params[:platform], 
                valid_platforms: "['PC','PS4','X1']"
            })
        end

    end

end
