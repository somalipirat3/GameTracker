# ala = Apex Legends Api
# consume apexlegendsapi.com
module ConsumeApi
    
    class Ala
        include HTTParty

        def initialize(options)
            @data = options
            @api_key = '69bbd61VKVukQpqUyxXw' 
            @endpoint = 'https://api.mozambiquehe.re/bridge?version=4'  
        end

        def legend
            @endpoint = "#{@endpoint}&platform=#{@data[:platform]}&player=#{@data[:username]}&auth=#{ @api_key}"
            response = self.class.get(@endpoint)
            if JSON.parse(response.parsed_response)['legends']
                response = JSON.parse(response.parsed_response)['legends']['selected']
                return {
                    legend: response['LegendName'],
                    ImgAssets: response['ImgAssets'],
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
