class ConsumeApi::SaveData
    def initialize(data)
        @data = data
        @game = game
        @player = player
        @membership = set_membership
        @saved_stats = 0
        @stats = stats

    end

    def game
       game = Game.find_or_create_by(title: 'Apex Legends')
       return {
           id: game.id,
           title: game.title,
           release_date: game.release_date,
           summary: game.summary
       }
    end

    def player
        username = @data[:player]['platformUserId'].to_s
        platform = @data[:player]['platformSlug'].to_s
        Player.find_or_create_by(username: username, platform: platform)
    end

    def set_membership
        Member.find_or_create_by(game_id: game[:id], player_id: player.id)
    end

    def stats

        @data[:stats].each do |stat|
            @saved_stats = @saved_stats +1
            legend = find_legend(stat[:legendName])
            stat = Stat.find_or_create_by(player_id: player.id, legend_id: legend.id)
            .update_attributes!(
                rank: stat[:stat][:rank].to_s,
                percentile: stat[:stat][:percentile].to_s,
                displayName: stat[:stat][:displayName].to_s,
                displayCategory: stat[:stat][:displayCategory].to_s,
                category: stat[:stat][:category],
                metadata: stat[:stat][:metadata],
                value: stat[:stat][:value],
                displayValue: stat[:stat][:displayValue],
                displayType: stat[:stat][:displayType]
            )
            
        end

        # 
    end

    private

    def find_legend name = ""
        Legend.find_or_create_by(game_id: game[:id], name: name)
    end

    
end