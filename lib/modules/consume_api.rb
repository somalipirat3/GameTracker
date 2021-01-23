module ConsumeApi

    def self.apexlegends_data options = {}
        api = ConsumeApi::TrackerDataOnly.new({username: options[:username], platform: options[:platform]})
        return {
            api: "Tracker GG With Proccessor",
            options: options,
            player: api.player,
            segments: api.segments
        }
    end

    def self.apex_legends options = {}
        if (["origin", "psn" , "xbl"].include? options[:platform])
            api = ConsumeApi::Tracker.new({username: options[:username], platform: options[:platform]})
            return {
                api: "Tracker GG",
                options: options,
                search_result: api.profile
            }
        elsif (["PC", "PS4" , "X1"].include? options[:platform])
            api = ConsumeApi::Ala.new({username: options[:username], platform: options[:platform]})
            return {
                api: "ALA",
                options: options,
                search_result: api.legend
            }
        else
            render_error_msg({
                invalid_platform: options[:platform], 
                valid_platforms: "['PC','PS4','X1', 'origin', 'psn' , 'xbl']"
            })
        end
    end


    def self.render_error_msg msg = 'error'
        return {
            error: msg
        }, status: 400
    end

end