class ApplicationController < ActionController::API

    before_filter :default_request_format

    def default_request_format
    request.format = :json
    end


    # render error massage
    def render_error_msg msg = 'error'
        render json: {
            error: msg
        }, status: 400
    end

end
