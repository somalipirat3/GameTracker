class ApplicationController < ActionController::API

    # render error massage
    def render_error_msg msg = 'error'
        render json: {
            error: msg
        }, status: 400
    end

end
