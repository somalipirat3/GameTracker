# Tracker.gg api
# Full profile requests 
class ConsumeApi::TrackerDataOnly
    include HTTParty

    def initialize(options = {})
        @data = options
        @api_key = Rails.application.credentials.api_keys[:tracker_gg][:key]
        endpoint = Rails.application.credentials.api_keys[:tracker_gg][:endpoint]
        @endpoint = "#{endpoint}apex/standard/profile/#{@data[:platform]}/#{@data[:username]}"
        @response = self.class.get(@endpoint, headers: {"TRN-Api-Key": @api_key})
    end

    def player
        return @response['data']['platformInfo']
    end

    def segments
        segments = []
        @response['data']['segments'].each do |segment|
            if segment['type'] == "legend"
                segments << {
                    legendName: legend(segment),
                    stat: stats(segment)
                }
            end
        end
        return segments
    end

    private

    def stats(stats)
        new_stats = {}
        stats['stats'].each do |stat|
            new_stats = {
                rank: stat[1]['rank'],
                percentile: stat[1]['percentile'],
                displayName: stat[1]['displayName'],
                displayCategory: stat[1]['displayCategory'],
                category: stat[1]['category'],
                metadata: stat[1]['metadata'],
                value: stat[1]['value'],
                displayValue: stat[1]['displayValue'],
                displayType: stat[1]['displayType']
            }
        end
        return new_stats
    end

    def legend (segment)
        segment['metadata']['name']
    end


end