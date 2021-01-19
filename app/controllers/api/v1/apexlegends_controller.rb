class Api::V1::ApexlegendsController < ApplicationController

    def search
        api = ConsumeApi.apex_legends({request_type: 'profile', platform: params[:platform], username: params[:username]})
        render json: api[:search_result]
    end

end
