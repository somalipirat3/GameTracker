# ala = Apex Legends Api
# consume apexlegendsapi.com
module ConsumeApi
    
    class Ala
        include HTTParty

        def initialize(options)
            @data = options
            @api_key = Rails.application.credentials.api_keys[:ala][:key]
            @endpoint = Rails.application.credentials.api_keys[:ala][:endpoint]
        end

        def legend
            @endpoint = "#{@endpoint}&platform=#{@data[:platform]}&player=#{@data[:username]}&auth=#{ @api_key}"
            response = self.class.get(@endpoint)
            if JSON.parse(response.parsed_response)['legends']
                response = JSON.parse(response.parsed_response)['legends']['selected']
                return {
                    legend: response['LegendName'],
                    img_assets: {
                        avatar: response['ImgAssets']['icon'],
                        banner: response['ImgAssets']['banner']
                    },
                    stats: response['data']
                }
            else
                return {
                    error: "Not Found"
                }
            end
        end

    end

end
